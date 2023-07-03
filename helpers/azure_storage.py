import os, uuid
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

# Maybe we should switch to Managed identity when in production
# https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview

def main():
    try:
        print("Azure Blob Storage Python quickstart sample")
        # Quickstart code goes here
        # Create the BlobServiceClient object
        default_credential = DefaultAzureCredential()


        AZURE_BLOB_HOST='https://stockagerncp.blob.core.windows.net'


        blob_service_client = BlobServiceClient(AZURE_BLOB_HOST, credential=default_credential)
        # Récupération de l'objet conteneur
        container_client = blob_service_client.get_container_client('ol-co2-import')
        # List the blobs in the container
        blob_list = container_client.list_blobs()
        for blob in blob_list:
            print(f"\t{blob.name}")
    except Exception as ex:
        print('Exception:')
        print(ex)
