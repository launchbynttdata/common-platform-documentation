# Usage Guide: Set up OpenVPN Client to connect to AWS Client VPN Endpoint [AWS] (0.5 hours)
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-Prerequisites)
3. [Installing OpenVPN Connect Client](#3-installing-openvpn-connect-client)
4. [Downloading Client Configuration](#4-downloading-client-configuration)
5. [Downloading Client Certificate and Key .p12 Bundle](#5-downloading-client-certificate-and-key-p12-bundle)
6. [Obtaining .p12 Bundle password](#6-obtaining-p12-bundle-password)
7. [Adding Cert .p12 Bundle to OpenVPN Connect](#7-adding-cert-p12-bundle-to-openvpn-connect)
8. [Adding Client Configuration Profile to OpenVPN Connect](#8-adding-client-configuration-profile-to-openvpn-connect)
9. [Assign Certificate to Profile](#9-assign-certificate-to-profile)
10. [Toggle VPN Connection](#10-toggle-vpn-connection)

## 1. **Introduction**
This guide will describe how to establlish connectivity to the AWS VPN endpoint in the launch.nttdata.com root account in order to reach specific AWS resources in this and our other AWS accounts (e.g. sandbox, prod) using the AWS CLI, AWS Console, and OpenVPN Connect using mutual certificate-based authentication.

The AWS Client VPN Endpoint has been configured with split-tunneling enabled, minimizing data transfer to and from AWS to that which is essential to this (or future) services.

While it is also possible to connect to the AWS Client VPN Endpoint using the AWS VPN Client application, the official documentation requires an unencrypted private key as part of the client configuration file, which is unsecure when using mutual certificate-based authentication. In the future, SSO SAML-based authentication is the desired end state, which will require corporate IT integrations with Okta for SAML endpoints and will likely require additional DNS configuration within our AWS accounts.  When this does occur, it should be possible to distribute a single file for configuration with without compromising security.

## 2. **Prerequisites**
- Follow the [Setting up AWS config guide](../../../../../..//platform/development-environments/local/aws/config/README.md)
- Follow the [Setting up aws-sso-utils guide](../../../../../..//platform/development-environments/local/aws/sso-login/README.md)
- For parsing of aws cli results, the following utilities are needed:
  - sed
  - cut
  - base64

## 3. **Installing OpenVPN Connect Client**
  - In order to install the current version of the OpenVPN Connect client (version 3.4.9 as-of the time of this documentation), follow the steps below

  1. In your web browser, visit https://openvpn.net/client/
* The site will attempt to detect the OS you are currently using and open the appropriate section for that OS.
* If it has opened a section for the incorrect target OS, click on the mid-page tab corresponding to your target OS
![OS Selection](pictures/OpenVPNConnectOSSelect.png)

  ### For MacOS:
1. Click on the large button labeled "Download OpenVPN Connect for Mac" to download the software as a .dmg image
2. Once the download has been completed, locate the downloaded file in your Downloads, and click to open
3. Double-click the installer for your device, based upon the CPU type your target device uses. For users within Launch, this is typically the "Mac with Apple Silicon chip" installer
![CPU Selection](pictures/OpenVPNConnectChooseCPU.png)
4. Proceed with the installer's installation steps
### For Windows:
1. Click on the large button labeled "Download OpenVPN Connect for Windows" to download the software as an .msi installer
2. Once the download has been completed, double-click on the downloaded .msi installer file to begin installation.
3. Proceed with the installer's installation steps
### For Linux:
1. Click on the large button labeled "Download OpenVPN Connect for Linux" to be directed to the OpenVPN 3 for Linux next-generation client
2. Click the large button labeled "Install OpenVPN 3 for Linux", and follow the instructions appropriate for your target Linux distribution

## 4. **Downloading Client Configuration**
The configuration has been stored centrally within the Launch AWS Root account's AWS Secrets Manager at arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/client_config

### Retrieve via AWS Console
You can retrieve the latest configuration via the AWS Console as follows:

  1. Log into the AWS Access Portal via [Okta](https://services-onentt.okta.com/app/UserHome)'s "AWS IAM Identity Center [2]" application tile
  2. Click to expand the entry for launch.nttdata.com, then click on your desired role name (e.g. AdministratorAccess) to log into that account's AWS Console
  3. In the AWS Console for Launch's AWS Root account, navigate to "AWS Secrets Manager" > Secrets > vpn/client_test/client_config
  
      ![AWS Secret Collapsed](pictures/AWSSecretCollapsed.png)

  4. Click the button labeled "Retrieve Secret Value", click Plaintext, select all lines (currently 51) within the Secret value section of the page (from the first line of "client" through the last line ending with "name"), copy, then paste the value into the text editor of your choice, and save the file in the path of your choice, with a .ovpn file extensioon

      ![AWS Secret Config](pictures/AWSSecretConfig.png)

### Retrieve via AWS CLI on MacOS and Linux
  Execute the following in your shell after having signed in via SSO and note that it has been saved to your home directory

```sh
CLIENT_CONFIG=$(aws --profile launch-root-admin secretsmanager get-secret-value  \
--secret-id=arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/client_config \
--query SecretString | sed -e 's/^"//' -e 's/"$//'); printf "%b" $CLIENT_CONFIG  > ~/client_config.ovpn
```

## 5. **Downloading Client Certificate and Key .p12 Bundle**
The cert bundle has been stored centrally within the Launch AWS Root account's AWS Secrets Manager at arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/cert_bundle

Because this file is binary rather than text, it cannot be retreived via the AWS Console and requires use of the AWS CLI
  ### Retrieve via AWS CLI on MacOS and Linux
  Execute the following in your shell after having signed in via SSO and note that it has been saved to your home directory

```sh
aws --profile launch-root-admin secretsmanager get-secret-value \
--secret-id=arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/cert_bundle \
--query SecretBinary --output text | base64 --decode > ~/cert_bundle.p12 && chmod 0600 ~/cert_bundle.p12
```

## 6. **Obtaining .p12 Bundle password**
The password for the cert bundle has been stored centrally within the Launch AWS Root account's AWS Secrets Manager at arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/passphrase

### Retrieve via AWS Console
- You can retrieve the cert bundle via the AWS Console as follows:
  1. Log into the AWS Access Portal via [Okta](https://services-onentt.okta.com/app/UserHome)'s "AWS IAM Identity Center [2]" application tile
  2. Click to expand the entry for launch.nttdata.com, then click on your desired role name (e.g. AdministratorAccess) to log into that account's AWS Console
  3. In the AWS Console for Launch's AWS Root account, navigate to "AWS Secrets Manager" > Secrets > vpn/client_test/client_config

      ![AWS Secret Collapsed](pictures/AWSSecretCollapsed.png)

  4. Click the button labeled "Retrieve Secret Value", click Key/value, then click the copy icon next to value in the Secret value column in order to get the cert bundle's password into your clipboard.

      ![AWS Secret Config](pictures/AWSSecretPassword.png)

### Retrieve via AWS CLI on MacOS and Linux
  Execute the following in your shell after having signed in via SSO, select the output value, and copy it to your clipboard

```sh
aws --profile launch-root-admin secretsmanager get-secret-value \
--secret-id=arn:aws:secretsmanager:us-east-2:538234414982:secret:vpn/client_test/passphrase \
--query SecretString --output text | cut -d: -f2 | sed -e 's/^"//' -e 's/"}$//'
```

## 7. **Adding Cert .p12 Bundle to OpenVPN Connect**
> [!IMPORTANT]
> When you first the OpenVPN Connect application, it is likely going to start with Import Profile; however, because a Certificate & Key must be available to assign to a profile before it can be saved, the profile configuration must be deferred until later.

In the upper-left of the application window, there is an expandable hamburger-style menu ![menu button](pictures/OpenVPNConnectHamburgerMenu.png) you must first click.  Once expanded, you will see other application features.

![menu](pictures/OpenVPNConnectHamburgerMenuExpanded.png)

Click on "Certificates and Tokens", then the tab for "PKCS #12", then "Add Certificate" toward the bottom of the window
![Certificates and Tokens PKCS #12](pictures/OpenVPNConnectCertsAndTokensHeader.png)

![Add Certificate](pictures/OpenVPNConnectAddCert.png)

Navigate to the path where you previously saved the .p12 certificate and key bundle, click the filename, then click "Open" and you will be prompted to enter the password from the prior section.

![Import PKCS #12](pictures/OpenVPNConnectImportPKCS12.png)

Enter the password, then click "OK" to continue.

> [!NOTE]
> MacOS users may be prompted at this point for the password to their openvpn-associated keychain, in order for it to be successfully and securely saved. 

If entered correctly, at this point, the "Certificates and Tokens" screen of OpenVPN Connect should display an entry for "vpnclienttest.launch.nttdata.com" with certificate and key icons to the left of the name.

![vpnclienttest.launch.nttdata.com](pictures/OpenVPNConnectCertsAndTokensEntry.png)

Click the back arrow at the top of the window to return to the application menu.

## 8. **Adding Client Configuration Profile to OpenVPN Connect**

Select the OpenVPN Connect menu option for "Import Profile", then the tab labeled "Upload File"

![Upload File](pictures/OpenVPNConnectImportProfile.png)

At this point you can either click the "Browse" button and select the .ovpn file which you downloaded earlier, or you can drag-and-drop the file into the target area above the button.

You should now see the label "Imported Profile" at the top of the window, with filled-in Profile Name and Server Names, but nothing assigned for "Certificate and Key"

![Imported Profile Without Cert](pictures/OpenVPNConnectImportedProfileNoCert.png)

> [!NOTE]
> Do not click "Connect" at this point, as your profile lacks a Certificate and Key, so the connection attempt will not succeed.

## 9. **Assign Certificate to Profile**
Click on the button labeled "Assign".  The application will return to "Certificates and Tokens" view, and you can now select your previously imported certificate bundle from the list under "PKCS #12".  After ensuring that the radio button for the correct certificate is selected, click "Confirm".

You should now see a completed profile such as the following:

![Imported Profile Without Cert](pictures/OpenVPNConnectImportedProfileWithCert.png)

You may now click "Connect".  If successful, you will soon see a status of "Connected" along with "Connection Stats" showing your VPN traffic throughput.

![Connected](pictures/OpenVPNConnectConnected.png)

## 10. **Toggle VPN Connection** 
When connected to the VPN, you can disconnect by clicking the slider toggle at the top of the window from the "On/Right/Green" position to toggle it to a disconnected state where it is "Off/Left/Gray"

![Toggle From Disconnected](pictures/OpenVPNConnectToggle.png)

To reconnect, simply click the slider toggle again to return to a Connected state.

