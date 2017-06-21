FROM centos:7

ENV passwd 123456

RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

#RUN useradd root
RUN echo "root:$passwd" | chpasswd
RUN echo "root ALL=(ALL) ALL" >> /etc/sudoers

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN mkdir /var/run/sshd
EXPOSE 22
EXPOSE 1000
CMD ["/usr/sbin/sshd", "-D"]
