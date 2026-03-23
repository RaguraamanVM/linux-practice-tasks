# EC2 EBS Volume and Snapshot Implementation

Deployed Linux and Windows EC2 instances and attached 5GB EBS volumes.
* On Linux, mounted volumes as /ebs-data (nvme1n1) and /ebs-data-snapshot (nvme2n1) after creating and restoring from a snapshot.
* On Windows, configured volumes as D: (original) and E: (snapshot). 
This demonstrates EBS volume attachment, snapshot creation, and volume restoration
