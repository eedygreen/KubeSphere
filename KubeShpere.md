# KubeShpere

## Installation of KubeSphere with Go on Ubuntu 18.04 LTS

###  Setup the Environment

1. Setting up VM with fresh start

2. Ensure the VM is connected to Internet

3. Install curl 

   ```sh
   # Install curl
   sudo apt install curl
   ```

4. Install Openssh-Server

   ```shell
   # Install Openssh-server
   sudo apt install openssh-server
   ```

5. Configure SSH Server

   ```sh
   sudo vim /etc/ssh/sshd_conf
   
   remove the # from port 22
   same goes for AddressFamily any
   ```

6. Restart SSH Server and Check the status

   ```shell
   # Restart SSH Server
   sudo systemctl restart sshd
   
   # Check status
   sudo systemctl status sshd
   ```

7.  Ensure user group is part of Root group

   ```shell
   # add the user to root group
   sudo usermod -aG sudo eedy
   
   #Check the user group
   groups eedy
   ```

   The output should be similar to this

   ```string
   eedy : eedy adm cdrom sudo dip plugdev lpadmin sambashare
   ```



### Install KubeSphere

1. [Read Installation Requiements](https://kubesphere.io/docs/quick-start/all-in-one-on-linux/#node-requirements)

2. Download the Key to the Ubuntu 18.04 LTS directory of your chosen

   ```shell
   # Download the key
   curl -sfL https://get-kk.kubesphere.io | VERSION=v1.0.1 sh -
   ```

   The Output should be similar to this

   ```shell
   Downloading kubekey v1.0.1 from https://github.com/kubesphere/kubekey/releases/download/v1.0.1/kubekey-v1.0.1-linux-amd64.tar.gz ...
   
   
   Kubekey v1.0.1 Download Complete!
   ```

3.  Change the kk script to be executable

   ```shell
   # make kk executable
   chmod +x kk
   ```

4. Create a configuration file

   ```shell
   # Create a configuration file
   ./kk create config --wth-kubernetes [version] --with-kubesphere [version]
   
   # this will a file config-sample.yaml
   # you can use the -f flag to specify the location you want it to be
   ```

   The default version (without specifying) is v3.0.0

5. Edit the Configuration file

   ```shell
   # Edit the config-sample.yaml file
   sudo vim config-sample.yaml
   
   # specify the privateKeyPath
   ```

   

   ```yaml
   Spec:
   	hosts:
   		- {name: master, address: 172.16.0.2, InternalAddress: 172.16.0.2, user: root, privateKeyPAth: "~/.ssh/id_rsa"}
   		- {name: node, address: 172.16.0.3, user: ubuntu, privateKeyPath: "~/.ssh/id_rsa"}
   ```

6.  Create the cluster

   ```shell
   sudo ./kk create cluster --with-kubernetes v1.17.9 --with-kubesphere
   ```

The successful output should be similar to this

```shell
eedy@ubuntu:~$ sudo ./kk create cluster --with-kubernetes v1.17.9 --with-kubesphere
+--------+------+------+---------+----------+-------+-------+-----------+--------+------------+-------------+------------------+--------------+
| name   | sudo | curl | openssl | ebtables | socat | ipset | conntrack | docker | nfs client | ceph client | glusterfs client | time         |
+--------+------+------+---------+----------+-------+-------+-----------+--------+------------+-------------+------------------+--------------+
| ubuntu | y    | y    | y       |          |       |       |           | y      |            |             |                  | PST 21:16:52 |
+--------+------+------+---------+----------+-------+-------+-----------+--------+------------+-------------+------------------+--------------+

This is a simple check of your environment.
Before installation, you should ensure that your machines meet all requirements specified at
https://github.com/kubesphere/kubekey#requirements-and-recommendations

Continue this installation? [yes/no]: yes
INFO[21:16:55 PST] Downloading Installation Files               
INFO[21:16:55 PST] Downloading kubeadm ...                      
INFO[21:17:08 PST] Downloading kubelet ...                      
INFO[21:17:40 PST] Downloading kubectl ...                      
INFO[21:17:54 PST] Downloading helm ...                         
INFO[21:18:02 PST] Downloading kubecni ...                      
INFO[21:18:13 PST] Configurating operating system ...           
[ubuntu 172.16.127.143] MSG:
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-arptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_local_reserved_ports = 30000-32767
no crontab for root
INFO[21:18:31 PST] Installing docker ...                        
INFO[21:19:54 PST] Start to download images on all nodes        
[ubuntu] Downloading image: kubesphere/etcd:v3.3.12
[ubuntu] Downloading image: kubesphere/pause:3.1
[ubuntu] Downloading image: kubesphere/kube-apiserver:v1.17.9
[ubuntu] Downloading image: kubesphere/kube-controller-manager:v1.17.9
[ubuntu] Downloading image: kubesphere/kube-scheduler:v1.17.9
[ubuntu] Downloading image: kubesphere/kube-proxy:v1.17.9
[ubuntu] Downloading image: coredns/coredns:1.6.9
[ubuntu] Downloading image: kubesphere/k8s-dns-node-cache:1.15.12
[ubuntu] Downloading image: calico/kube-controllers:v3.15.1
[ubuntu] Downloading image: calico/cni:v3.15.1
[ubuntu] Downloading image: calico/node:v3.15.1
[ubuntu] Downloading image: calico/pod2daemon-flexvol:v3.15.1
INFO[21:27:11 PST] Generating etcd certs                        
INFO[21:27:15 PST] Synchronizing etcd certs                     
INFO[21:27:15 PST] Creating etcd service                        
[ubuntu 172.16.127.143] MSG:
Created symlink /etc/systemd/system/multi-user.target.wants/etcd.service → /etc/systemd/system/etcd.service.
INFO[21:27:33 PST] Starting etcd cluster                        
[ubuntu 172.16.127.143] MSG:
Configuration file will be created
INFO[21:27:34 PST] Refreshing etcd configuration                
Waiting for etcd to start
INFO[21:27:41 PST] Backup etcd data regularly                   
INFO[21:27:42 PST] Get cluster status                           
[ubuntu 172.16.127.143] MSG:
Cluster will be created.
INFO[21:27:42 PST] Installing kube binaries                     
Push /home/eedy/kubekey/v1.17.9/amd64/kubeadm to 172.16.127.143:/tmp/kubekey/kubeadm   Done
Push /home/eedy/kubekey/v1.17.9/amd64/kubelet to 172.16.127.143:/tmp/kubekey/kubelet   Done
Push /home/eedy/kubekey/v1.17.9/amd64/kubectl to 172.16.127.143:/tmp/kubekey/kubectl   Done
Push /home/eedy/kubekey/v1.17.9/amd64/helm to 172.16.127.143:/tmp/kubekey/helm   Done
Push /home/eedy/kubekey/v1.17.9/amd64/cni-plugins-linux-amd64-v0.8.6.tgz to 172.16.127.143:/tmp/kubekey/cni-plugins-linux-amd64-v0.8.6.tgz   Done
INFO[21:28:23 PST] Initializing kubernetes cluster              
[ubuntu 172.16.127.143] MSG:
W1221 21:28:28.895931   57122 defaults.go:186] The recommended value for "clusterDNS" in "KubeletConfiguration" is: [10.233.0.10]; the provided value is: [169.254.25.10]
W1221 21:28:28.897149   57122 validation.go:28] Cannot validate kube-proxy config - no validator is available
W1221 21:28:28.897753   57122 validation.go:28] Cannot validate kubelet config - no validator is available
[init] Using Kubernetes version: v1.17.9
[preflight] Running pre-flight checks
	[WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
	[WARNING FileExisting-ebtables]: ebtables not found in system path
	[WARNING FileExisting-ethtool]: ethtool not found in system path
	[WARNING FileExisting-socat]: socat not found in system path
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [ubuntu kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local lb.kubesphere.local kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local localhost lb.kubesphere.local ubuntu ubuntu.cluster.local] and IPs [10.233.0.1 172.16.127.143 127.0.0.1 172.16.127.143 10.233.0.1]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] External etcd mode: Skipping etcd/ca certificate authority generation
[certs] External etcd mode: Skipping etcd/server certificate generation
[certs] External etcd mode: Skipping etcd/peer certificate generation
[certs] External etcd mode: Skipping etcd/healthcheck-client certificate generation
[certs] External etcd mode: Skipping apiserver-etcd-client certificate generation
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[controlplane] Adding extra host path mount "host-time" to "kube-controller-manager"
W1221 21:28:45.339453   57122 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[controlplane] Adding extra host path mount "host-time" to "kube-controller-manager"
W1221 21:28:45.387553   57122 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[controlplane] Adding extra host path mount "host-time" to "kube-controller-manager"
W1221 21:28:45.390812   57122 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[kubelet-check] Initial timeout of 40s passed.
[apiclient] All control plane components are healthy after 55.509415 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.17" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node ubuntu as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node ubuntu as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: 6qg1e7.efey7ahfx0kwxjdt
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join lb.kubesphere.local:6443 --token 6qg1e7.efey7ahfx0kwxjdt \
    --discovery-token-ca-cert-hash sha256:2a9c31a9f84178800b01f9ceffb5fb0011ec1c6fc7e0d9369fd0020c81450f47 \
    --control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join lb.kubesphere.local:6443 --token 6qg1e7.efey7ahfx0kwxjdt \
    --discovery-token-ca-cert-hash sha256:2a9c31a9f84178800b01f9ceffb5fb0011ec1c6fc7e0d9369fd0020c81450f47
[ubuntu 172.16.127.143] MSG:
node/ubuntu untainted
[ubuntu 172.16.127.143] MSG:
node/ubuntu labeled
[ubuntu 172.16.127.143] MSG:
service "kube-dns" deleted
[ubuntu 172.16.127.143] MSG:
service/coredns created
[ubuntu 172.16.127.143] MSG:
serviceaccount/nodelocaldns created
daemonset.apps/nodelocaldns created
[ubuntu 172.16.127.143] MSG:
configmap/nodelocaldns created
[ubuntu 172.16.127.143] MSG:
I1221 21:30:10.430059   59159 version.go:251] remote version is much newer: v1.20.1; falling back to: stable-1.17
W1221 21:30:11.702321   59159 validation.go:28] Cannot validate kube-proxy config - no validator is available
W1221 21:30:11.702565   59159 validation.go:28] Cannot validate kubelet config - no validator is available
[upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
[upload-certs] Using certificate key:
bfdcf95bf9ddd1f1176c575408efe70c00901295887539d4aa9095fe5805867d
[ubuntu 172.16.127.143] MSG:
secret/kubeadm-certs patched
[ubuntu 172.16.127.143] MSG:
secret/kubeadm-certs patched
[ubuntu 172.16.127.143] MSG:
secret/kubeadm-certs patched
[ubuntu 172.16.127.143] MSG:
W1221 21:30:12.484573   59205 validation.go:28] Cannot validate kube-proxy config - no validator is available
W1221 21:30:12.484690   59205 validation.go:28] Cannot validate kubelet config - no validator is available
kubeadm join lb.kubesphere.local:6443 --token 700w0c.1tp391826wo3f1hm     --discovery-token-ca-cert-hash sha256:2a9c31a9f84178800b01f9ceffb5fb0011ec1c6fc7e0d9369fd0020c81450f47
[ubuntu 172.16.127.143] MSG:
NAME     STATUS     ROLES           AGE   VERSION   INTERNAL-IP      EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
ubuntu   NotReady   master,worker   34s   v1.17.9   172.16.127.143   <none>        Ubuntu 18.04.5 LTS   5.3.0-28-generic   docker://19.3.6
INFO[21:30:12 PST] Deploying network plugin ...                 
[ubuntu 172.16.127.143] MSG:
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
daemonset.apps/calico-node created
serviceaccount/calico-node created
deployment.apps/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
INFO[21:30:22 PST] Joining nodes to cluster                     
[ubuntu 172.16.127.143] MSG:
storageclass.storage.k8s.io/local created
serviceaccount/openebs-maya-operator created
clusterrole.rbac.authorization.k8s.io/openebs-maya-operator created
clusterrolebinding.rbac.authorization.k8s.io/openebs-maya-operator created
configmap/openebs-ndm-config created
daemonset.apps/openebs-ndm created
deployment.apps/openebs-ndm-operator created
deployment.apps/openebs-localpv-provisioner created
INFO[21:30:28 PST] Deploying KubeSphere ...                     
v3.0.0
[ubuntu 172.16.127.143] MSG:
namespace/kubesphere-system created
namespace/kubesphere-monitoring-system created
[ubuntu 172.16.127.143] MSG:
secret/kube-etcd-client-certs created
[ubuntu 172.16.127.143] MSG:
namespace/kubesphere-system unchanged
serviceaccount/ks-installer created
customresourcedefinition.apiextensions.k8s.io/clusterconfigurations.installer.kubesphere.io created
clusterrole.rbac.authorization.k8s.io/ks-installer created
clusterrolebinding.rbac.authorization.k8s.io/ks-installer created
deployment.apps/ks-installer created
clusterconfiguration.installer.kubesphere.io/ks-installer created


INFO[21:36:17 PST] Installation is complete.

Please check the result using the command:

       kubectl logs -n kubesphere-system $(kubectl get pod -n kubesphere-system -l app=ks-install -o jsonpath='{.items[0].metadata.name}') -f

```

### Work Around

One of the problem encountered was the ssh key not found in the root node=[host_ip]

To solve this problem

I transfer the ssh keys to the root directory. 

*The reason why we need the root user group.*

```shell
# create .ssh directory in the root directory
sudo mkdir -p /root/.ssh

# I copied the authorized_keys, id_rsa, id_rsa.pub to the root/.ssh 
sudo cp /home/eedy/.ssh/authourized_kyes /root/.ssh/
```



