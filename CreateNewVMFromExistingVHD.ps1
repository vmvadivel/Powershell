# ReadMe first :: Create a windows VM from a specialzied disk - https://docs.microsoft.com/en-us/azure/virtual-machines/windows/create-vm-specialized

# Login into the Azure account and the subscription details
Login-AzureRmAccount
Get-AzureRmSubscription

# The virtual network name
$vnetname = "yourvnet_name_comes_here"

# The resource group name
$rgName = "yourRG_name_comes_here"

# specify the location like SouthIndia or CentralIndia etc.,
$location = "yourlocation_comes_here"

$vnet = Get-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $rgName

# Creating IP 
$ipName = "myIP"

# Creating a public ip which is going to be dynamic. If you need static change the allocation method appropriately
$pip = New-AzureRmPublicIpAddress -Name $ipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic

# Creating NIC
$nicName = "myNicName"
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

# Set the URI for the VHD that you want to use.
$osDiskUri = "https://yourvhdfilename.vhd"

# Declare the VM name and the required size. 
$vmName = "New-VM-Name-Comes-Here"
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_A2"

# Add the NIC
$vm = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id

# Add the OS disk by using the URL of the copied OS VHD. In this example, when the OS disk is created, the 
# term "osDisk" is appened to the VM name to create the OS disk name. This example also specifies that this 
# Windows-based VHD should be attached to the VM as the OS disk.
$osDiskName = $vmName + "osDisk"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $osDiskName -VhdUri $osDiskUri -CreateOption attach -Windows

#Create the new VM
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vm
