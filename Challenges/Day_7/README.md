# Bash Blaze Day 7 Challenge: Mastering Remote Server Management and Web App Deployment

## Challenge Objectives

1. Set up a network of three virtual machines: `server`, `client1`, and `client2`.
2. Generate SSH key pairs for secure authentication.
3. Configure passwordless SSH authentication between the machines.
4. Write a Bash script that remotely executes commands on the `client1` and `client2` VMs from the `server`.
5. Use `scp` to securely transfer files between the VMs.
6. Containerize a simple web application using Docker.
7. Deploy the web application on the `client1` and `client2` VMs using Nginx as a reverse proxy.
8. Validate successful web application deployment.

## Instructions

### Setting up Virtual Machines

1. Use your preferred virtualization software (e.g., VirtualBox or VMware) to create three VMs: `server`, `client1`, and `client2`.
2. Ensure all VMs are connected to the same internal network for seamless communication.

### Generating SSH Key Pairs and Authentication

1. On the `server` VM, generate an SSH key pair using the `ssh-keygen` command.
2. Copy the public key (`id_rsa.pub`) to both `client1` and `client2` VMs using `ssh-copy-id`.

### Remote Command Execution and File Transfer

1. Write the Bash scripts `remote_execute.sh` and `secure_transfer.sh` on the `server` VM as per the provided challenge details.
2. Execute the scripts to remotely execute commands on `client1` and `client2` VMs and securely transfer files between them.

### Containerizing and Deploying the Web Application

1. On the `server` VM, write a Dockerfile to containerize a simple web application.
2. Build the Docker image on the `server` VM.
3. Write the Bash script `deploy_app.sh` on `client1` and `client2` VMs to deploy the web application using Docker and Nginx.

### Completion and Submission

1. Take Snapshot of the successful remote command execution, file transfers, and the deployed web application.
2. Share your scripts and Snapshot in the Bash Blaze challenge community or your GitHub repository to complete the challenge.

## Challenge Completion

Congratulations! You have now mastered the art of remote server management and web application deployment using Bash, Docker, and Nginx. You've successfully tackled the final day challenge of Bash Blaze. We hope you had an exciting and insightful journey throughout this challenge!

Happy scripting, and may your coding endeavors continue to shine in the world of technology!

---

This challenge is a part of the Bash Blaze series by [TWS]. For more challenges and exciting content, stay connected to the TWS community and keep learning!
