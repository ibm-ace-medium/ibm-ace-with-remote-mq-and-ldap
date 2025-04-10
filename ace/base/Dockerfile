FROM refactoritskibm/rhel-base

# Download and reference the ACE-LINUX64-DEVELOPER.tar.gz from here https://www.ibm.com/resources/mrs/assets?source=swg-wmbfd eg.
#ARG DOWNLOAD_URL=https://iwm.dhe.ibm.com/sdfdl/v2/regs2/mbford/Xa.2/Xb.WJL1CuPI9omVpMFwXvd6iLfcvewDDeaWm79J0anPNV0/Xc.12.0.12.2-ACE-LINUX64-DEVELOPER.tar.gz/Xd./Xf.lPr.D1vk/Xg.12878886/Xi.swg-wmbfd/XY.regsrvs/XZ.NjOGdYG4NMtKONG1jscLwjR1xBRD4zjw/12.0.12.2-ACE-LINUX64-DEVELOPER.tar.gz
ARG ACE_DOWNLOAD_URL=http://192.168.15.12:9000/12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz
ARG MQ_CLIENT_DOWNLOAD_URL=http://192.168.15.12:9000/9.3.5.1-IBM-MQC-LinuxX64.tar.gz

#ARG ACE_DOWNLOAD_URL=https://iwm.dhe.ibm.com/sdfdl/v2/regs2/mbford/Xa.2/Xb.WJL1CuPI9omVm7-zA3_EoN0GonOTsOUBwvD4GiI8N9Q/Xc.12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz/Xd./Xf.lPr.D1vk/Xg.12946713/Xi.swg-wmbfd/XY.regsrvs/XZ.hs0R8RAgPlHoGfFoWk6W7HLntXCGAlWo/12.0.12.4-ACE-LINUX64-DEVELOPER.tar.gz
#ARG MQ_CLIENT_DOWNLOAD_URL=https://ak-delivery04-mul.dhe.ibm.com/sdfdl/v2/sar/CM/WS/0c72y/0/Xa.2/Xb.jusyLTSp44S049xga3jSAIdkiucpdLpncjE3qGeC11RX21JVV-EUdJet0LU/Xc.CM/WS/0c72y/0/9.3.5.1-IBM-MQC-LinuxX64.tar.gz/Xd./Xf.LPR.D1VK/Xg.12948221/Xi.habanero/XY.habanero/XZ.yZZvI7PKqNsnOddjf-Qkms3RTW1O0BxB/9.3.5.1-IBM-MQC-LinuxX64.tar.gz

# Add required license as text file in Liceses directory (GPL, MIT, APACHE, Partner End User Agreement, etc)
COPY /licenses/ /licenses/

RUN mkdir -p /opt/ibm/ace-12 \
    && curl ${ACE_DOWNLOAD_URL} | \
    tar zx --absolute-names \
    --exclude ace-12.0.*.0/tools \
    --exclude ace-12.0.*.0/server/tools/ibm-dfdl-java.zip \
    --exclude ace-12.0.*.0/server/tools/proxyservlet.war \
    --exclude ace-12.0.*.0/server/bin/TADataCollector.sh \
    --exclude ace-12.0.*.0/server/transformationAdvisor/ta-plugin-ace.jar \
    --strip-components 1 \
    --directory /opt/ibm/ace-12

RUN mkdir -p /opt/ibm/MQClient \
    && curl ${MQ_CLIENT_DOWNLOAD_URL} | \
    tar zx --absolute-names \
    --strip-components 1 \
    -C /opt/ibm/MQClient

RUN rpm -ivh  \
    /opt/ibm/MQClient/MQSeriesClient-9.*.x86_64.rpm  \
    /opt/ibm/MQClient/MQSeriesGSKit-9.*.x86_64.rpm  \
    /opt/ibm/MQClient/MQSeriesRuntime-9.*.x86_64.rpm  \
    /opt/ibm/MQClient/MQSeriesJava-9.*.x86_64.rpm  \
    /opt/ibm/MQClient/MQSeriesJRE-9.*.x86_64.rpm


RUN /opt/ibm/ace-12/ace make registry global accept license deferred \
    && useradd --uid 1001 --create-home --home-dir /home/aceuser --shell /bin/bash -G mqbrkrs aceuser \
    && echo ". /opt/ibm/ace-12/server/bin/mqsiprofile" >> /home/aceuser/.bashrc

ENV LICENSE=accept
USER aceuser:mqbrkrs

#ENTRYPOINT ["bash", "-c", "sleep 600"]
CMD ["/bin/bash"]