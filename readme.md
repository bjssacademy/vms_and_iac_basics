# Virtual Machines and Infrastructure as Code

You want a computer that runs in the cloud, that behaves like a physical machine, but without the hardware sitting on your desk — that's a virtual machine.

## What are Virtual Machines?

You can think of a VM as a complete computer system that lives in the cloud. It's like having a virtual copy of a physical computer—complete with an operating system, storage, and network access—all running on a powerful server in a data center somewhere.

## How VMs Work
VMs rely on a technology called *virtualization*. This technology allows a single physical server, known as a *host*, to create and run multiple VMs simultaneously. Each VM operates independently, just like a standalone computer, even though they share the same physical hardware.

## Cloud Providers and VMs

Major cloud providers like Azure, AWS, and Google Cloud offer VM services. Each provider has its own interface and tools for managing VMs, making it easy to deploy, scale, and manage VMs in their respective environments.

## Deploying Virtual Machines
To create a VM, you typically specify details like:

- Operating System
- Hardware Configuration
- Networking

## Infrastructure as a Service (IaaS)

So you need a bunch of computers, storage space, and networking equipment to run your business applications. Instead of buying all that hardware and setting it up in your own data center, you can use IaaS. It’s like renting everything you need from a cloud provider, such as Microsoft Azure, Amazon Web Services (AWS), or Google Cloud Platform (GCP).

We're going to rent that space from Azure, and deploy our VMs on it.

## Deploying Virtual Machines, Hands-on

Okay, enough reading, let's deploy our own VM.

[>> Manually deploying a VM](./part1)

---

## Infrastructure as Code (IaC)

IaC is all about automating the process of managing and provisioning your infrastructure through code. 

Instead of clicking around in a web console ("clickops") to set up servers and networks, you write code that describes exactly what you want your infrastructure to look like. This code can then be executed to deploy and manage your infrastructure in a consistent and repeatable way.

[>> Deploying a VM using Terraform](./part2)

[>> Deploying a VM using ARM](./part3)

[>> Deploying a VM using Bicep](./part4)

[>> Blob Storage](./part5/)