# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
  name     = "rg-academytf-${var.team_name}-${var.user_id}"
  location = "uksouth"

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
    mynewtag   = "mynewtagvalue"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "vnet-academytf-${var.team_name}-${var.user_id}"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
  }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "snet-academytf-${var.team_name}-${var.user_id}"
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "pip-academytf-${var.team_name}-${var.user_id}"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  allocation_method   = "Dynamic"

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "nsg-academytf-${var.team_name}-${var.user_id}"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
  }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "nic-academytf-${var.team_name}-${var.user_id}"
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "vm-academytf-${var.team_name}-${var.user_id}"
  location              = "uksouth"
  resource_group_name   = azurerm_resource_group.myterraformgroup.name
  network_interface_ids = [azurerm_network_interface.myterraformnic.id]
  size                  = "Standard_B1ls"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "${var.user_id}vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  boot_diagnostics {}

  custom_data = base64encode(<<-EOT
    #!/usr/bin/env bash
    sudo apt-get update -y
    sudo apt-get install nginx -y
    sudo systemctl restart nginx
  EOT
  )

  tags = {
    project = "academy2022"
    team    = var.team_name
    user    = var.user_id
  }
}

# Dynamically allocated IP so we need ot look this up after
data "azurerm_public_ip" "public_ip" {
  name = "pip-academytf-${var.team_name}-${var.user_id}"
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  depends_on = [ azurerm_public_ip.myterraformpublicip, azurerm_linux_virtual_machine.myterraformvm ]
}


# Output the Public IP
output "azurerm_public_ip" {
  value       = data.azurerm_public_ip.public_ip.ip_address
  description = "Public IP associated with the VM instance"
}
