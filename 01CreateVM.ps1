  #Login into Microsoft Azure
  Login-AzureRmAccount

  #Create a Resource Group
  $resourceGroupName = "VadiTestRG"
  $location = "south india"
  New-AzureRmResourceGroup -Name $resourceGroupName 
                           -location $location

  #Create a new storage account  
  $storageAccountName = "vadistoragetestsi"
  $storageAccountLocation = "southindia"
  $storageAccountType = "Standard_LRS"
  New-AzureRmStorageAccount -Name $storageAccountName `
                            -Location $storageAccountLocation `
                            -Type $storageAccountType `
                            -ResourceGroupName $resourceGroupName
