
# Before you begin, you must create an IAM User with AmazonS3FullAccess policy.
# You will need the User's Access Key ID and Secret Access Key for this lab.

# First, we need to create a Cloud9 instance and ssh into it.
# Next, download Pyspark and use it to get our dataset via API.
# Then we're going to change the json file into a dataframe.
# Finally, we'll load the dataset into our S3 bucket for analysis in Databricks.

# In Databricks we will mount our S3 bucket and extract our data for analysis.

############################################
# INITIALIZE LAB PARAMETERS AND VARIABLES  #
############################################
CLIENT_IP="12.345.678.910"      # change this to your ip
LAB_ENV_NAME="lab-emr-cluster"
LAB_STACK_NAME="${LAB_ENV_NAME}-stack"
LAB_KEY_NAME="${LAB_ENV_NAME}-keypair"
LAB_KEY_FILE="${LAB_KEY_NAME}.pem"
CLOUD9_PRIVATE_IP=`hostname -i`

############################################
# CREATE LAB INFRASTRUCTURE USING AWS CLI  #
############################################
aws configure set region us-east-1
export AWS_SHARED_CREDENTIALS_FILE=/home/ec2-user/.aws/credentials

CIDR_SUFFIX=
if [ "${CLIENT_IP}" = "0.0.0.0" ]; then
    CIDR_SUFFIX="/0"
else
    CIDR_SUFFIX="/32"
fi

aws ec2 create-key-pair \
    --key-name "${LAB_KEY_NAME}" \
    --query 'KeyMaterial' \
    --output text > "${LAB_KEY_FILE}"

chmod 400 "${LAB_KEY_FILE}" #change permissions

aws cloudformation deploy \
  --template-file ./template.json \
  --stack-name "lab-emr-cluster-stack" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    Name="${LAB_ENV_NAME}" \
    InstanceType=m5.xlarge \
    ClientIP="${CLIENT_IP}${CIDR_SUFFIX}" \
    Cloud9IP="${CLOUD9_PRIVATE_IP}/32" \
    InstanceCount=2 \
    KeyPairName="${LAB_KEY_NAME}" \
    ReleaseLabel="emr-5.32.0" \
    EbsRootVolumeSize=32

LAB_CLUSTER_ID=`aws emr list-clusters --query "Clusters[?Name=='${LAB_ENV_NAME}'].Id | [0]" --output text`
aws emr wait cluster-running --cluster-id ${LAB_CLUSTER_ID}

############################################
# COPY FILES, CONNECT TO EMR MASTER NODE   #
############################################

LAB_EMR_MASTER_PUBLIC_HOST=`aws emr describe-cluster --cluster-id ${LAB_CLUSTER_ID} --query Cluster.MasterPublicDnsName --output text`
echo $LAB_EMR_MASTER_PUBLIC_HOST > emr-master-public-host.txt

scp -r -i "${LAB_KEY_FILE}" /home/ec2-user/environment/lab-files "hadoop@${LAB_EMR_MASTER_PUBLIC_HOST}:/home/hadoop"

ssh -i "${LAB_KEY_FILE}" "hadoop@${LAB_EMR_MASTER_PUBLIC_HOST}"

############################################
#        CONFIGURE AWS CREDENTIALS         #
############################################

# Configure AWS credentials.
aws configure
AWS Access Key ID: YOUR KEY          # modify this
AWS Secret Access Key: YOUR SECRET   # modify this
Default region name: YOUR REGION     # modify this
Default output format: json

###########################################
#  UPDAT VM & SET UP PYTHON ENVIRONMENT   #
###########################################

# Update vm instance and install python.
sudo yum update -y
sudo yum install python3 -y
pip install pandas --user
pip install requests --user 

############################################
#   START PYSPARK & DOWNLOAD LIBRIARIES    #
############################################

# Start pyspark session.
pyspark

# Install dependencies.
from pyspark.sql.functions import *
from pyspark.sql.types import *
import pandas as pd
import requests

############################################
#   DATA EXTRACT, TRANSFORM & LOAD (ETL)   #
############################################

# Create a function that converts json file to dataframe.
def json_to_dataframe(doc):
    """
    Convert json file into a dataframe.
    """
    return pd.DataFrame(doc.json()[1:], columns=doc.json()[0])

# Assign api to a variable and use request to fetch data from api.
url = "https://api.census.gov/data/2019/pep/charage?get=AGE,SEX,RACE,POP&DATE_CODE=3,4,5,6,7,8,9,10,11,12&NAME&for=state:*&key=YOUR-KEY" # modify YOUR KEY

doc = requests.request("GET", url)

# Convert json file into a dataframe.
data = json_to_dataframe(doc)

# Convert the dataframe into a spark dataframe.
df = spark.createDataFrame(data)

# Save file to s3 bucket.
df.coalesce(1).write.format("csv").option("header", "true").save('s3a://YOUR-BUCKET/FILE_NAME.csv') # modify YOUR-BUCKET and FILE_NAME

############################################
#   EXIT PYSPARK & DELETE LAB RESOURCES    #
############################################

exit()

# Since, you have configured the AWS credential to your IAM User's, you won't be able to execute the commands below. You can manually delete the 
# cloudformations and key pair. 
aws cloudformation delete-stack --stack-name "lab-emr-cluster-stack"
aws ec2 delete-key-pair --key-name "${LAB_KEY_NAME}"
rm -f "${LAB_KEY_FILE}"
aws cloudformation wait stack-delete-complete --stack-name "lab-emr-cluster-stack"