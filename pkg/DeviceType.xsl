<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" version="1.0" encoding="UTF-8"  omit-xml-declaration="yes"/>

  <xsl:strip-space elements="*"/>

  <xsl:template match="/" >
    <xsl:call-template name="PackageXML" />
  </xsl:template>

  <xsl:template name="PackageXML" >
    <xsl:variable name="sCompId">
      <xsl:value-of select="//SoftwareComponent/SupportedDevices/Device/@componentID"/>
    </xsl:variable>

    <xsl:choose >
      <xsl:when test="//SoftwareComponent/LUCategory/@value= 'NIC' or //SoftwareComponent/LUCategory/@value= 'Network' or //SoftwareComponent/LUCategory/@value= 'Fibre Channel'" >
	<xsl:choose >
	  <xsl:when test="//SoftwareComponent/ComponentType/@value= 'FRMW'" >
	    <xsl:choose>	
	      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Seagate ES')" >
		<xsl:value-of select="string('SASHDD SASHDD')" />
	      </xsl:when>
              <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'intel', 'INTEL'), 'INTEL')" >
                <xsl:value-of select="string('INTEL FRMW')" />
              </xsl:when>
              <xsl:when test="$sCompId = '27524'" >
                <xsl:value-of select="string('INTEL FRMW')" />
              </xsl:when>
              <xsl:when test="$sCompId = '28546'" >
                <xsl:value-of select="string('INTEL FRMW')" />
              </xsl:when>
              <xsl:when test="$sCompId = '29254' or $sCompId = '27485' or $sCompId = '27476' or $sCompId = '27482'" >
                <xsl:value-of select="string('INTEL FRMW')" />
              </xsl:when>
              <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'qlogic', 'QLOGIC'), 'QLOGIC')" >
                <xsl:value-of select="string('QLOGIC FRMW')" />
              </xsl:when>
              <xsl:when test="$sCompId = '27489' or $sCompId = '27486' or $sCompId = '25504' or $sCompId = '29428'" >
                <xsl:value-of select="string('QLOGIC FRMW')" />
              </xsl:when>
              <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'emulex', 'EMULEX'), 'EMULEX')" >
                <xsl:value-of select="string('EMULEX FRMW')" />
              </xsl:when>
              <xsl:when test="//SoftwareComponent/LUCategory/@value= 'Fibre Channel'" >
                <xsl:value-of select="string('EMULEX FRMW')" />
              </xsl:when>

	      <xsl:otherwise >
		<xsl:value-of select="string('BROADCOM FRMW')" />
	      </xsl:otherwise>
	    </xsl:choose>	
	  </xsl:when>					
	  <xsl:otherwise >
	    <xsl:choose >
	      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'intel', 'INTEL'), 'INTEL')" >
		<xsl:value-of select="string('INTEL NIC')" />
	      </xsl:when>					
	      <xsl:otherwise >
		<xsl:value-of select="string('BROADCOM NIC')" />
	      </xsl:otherwise>
	    </xsl:choose>	
	  </xsl:otherwise>
	</xsl:choose>	
      </xsl:when>

      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Seagate ES')" >
	<xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/LUCategory/@value= 'SAS Drive'" >
        <xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>

      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Seagate DRAGONFLY ES')" >
	<xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Seagate 3.5')" >
	<xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'PCIe SSD') or contains(string(//SoftwareComponent/Name/Display), 'PCIE SSD')" >
	<xsl:choose>
	 <xsl:when test="//SoftwareComponent/ComponentType/@value= 'FRMW'" >
              <xsl:value-of select="string('FRMW PCISSD')" />
          </xsl:when>
	</xsl:choose>
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Samsung SSD')" >
	<xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'Backplane Expander')" >
	<xsl:value-of select="string('SASBP SASBP')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'SAS Expander')" >
	<xsl:value-of select="string('SASBP SASBP')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/Name/Display), '12G SEP')" >
	<xsl:value-of select="string('SASBP SASBP')" />
      </xsl:when>
      <xsl:when test="//ComponentType/@value='DRVR' and contains(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC S')">
	<xsl:value-of select="string('DRVR SOFT')" />
      </xsl:when>
      <xsl:when test="//ComponentType/@value='DRVR'" >
	<xsl:apply-templates select="//ComponentType" />
	<xsl:apply-templates select="//LUCategory" />		
      </xsl:when>
      <xsl:when test="//ComponentType/@value='APAC'" >
	<xsl:choose>	
	  <xsl:when test="//SoftwareComponent/Category/@value = 'DI' or //SoftwareComponent/Category/@value = 'Diagnostics'">
	    <xsl:value-of select="string('MASER DIAGS')" />
	  </xsl:when>
	  <xsl:when test="//SoftwareComponent/Category/@value = 'SM'">
	    <xsl:value-of select="string('MASER USC')" />
	  </xsl:when>
	  <xsl:when test="//SoftwareComponent/Category/@value = 'SV' or //SoftwareComponent/Category/@value = 'DD' or //SoftwareComponent/Category/@value = 'Drivers for OS Deployment'">
	    <xsl:choose>
       	      <xsl:when test="$sCompId = '18981'" >
		<xsl:value-of select="string('MASER DP')" />
	      </xsl:when>
	      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'drivers pack', 'Drivers Pack'), 'Drivers Pack')" >
		<xsl:value-of select="string('MASER DP')" />
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="string('MASER USC')" />
	      </xsl:otherwise>					
	    </xsl:choose>	
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="string('MASER Unknown')" />
	  </xsl:otherwise>					
	</xsl:choose>	
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '25227'">
        <xsl:value-of select="string('ESM IDrac7')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ESM' and $sCompId= '25227'">
        <xsl:value-of select="string('ESM IDrac7')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/@releaseID='R201874'">
        <xsl:value-of select="string('FRMW BMC')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/@releaseID='R219074'">
        <xsl:value-of select="string('FRMW BMC')" />
      </xsl:when>

      <xsl:when test="//SoftwareComponent/Category/@value = 'ESM' and $sCompId= '5814'">
        <xsl:value-of select="string('FRMW BMC')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '5814'">
        <xsl:value-of select="string('FRMW BMC')" />
      </xsl:when>
 
      <xsl:when test="//SoftwareComponent/Category/@value = 'ESM' and $sCompId= '160'">
        <xsl:value-of select="string('ESM IDrac7')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '30815'">
        <xsl:value-of select="string('ESM IDrac7')" />
      </xsl:when>



      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '13791'">
        <xsl:value-of select="string('ESM IMC')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '15051'">
	<xsl:choose>	
	  <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'v.1')" >
	    <xsl:value-of select="string('ESM IMC')" />
	  </xsl:when>
	  <xsl:when test="contains(string(//SoftwareComponent/Name/Display), 'v.2')" >
	    <xsl:value-of select="string('ESM Oxygen')" />
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="string('ESM Oxygen')" />
	  </xsl:otherwise>					
	</xsl:choose>	
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '20137'">
	<xsl:value-of select="string('ESM Nitrogen')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'ES' and $sCompId= '160'">
	<xsl:value-of select="string('ESM Nitrogen')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'SN' and $sCompId= '13910'">
	<xsl:value-of select="string('MPTLSI U320')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'TH'" >
	<xsl:choose>	
          <xsl:when test="$sCompId = '6152'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '6154'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '1018'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '1048'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '8184'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '1359'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '3953'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '2327'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '5301'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '15555'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '17611'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>		
          <xsl:when test="$sCompId = '6154'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>		
          <xsl:when test="$sCompId = '17386'" >
            <xsl:value-of select="string('Tape Quantum')" />
	  </xsl:when>		
          <xsl:when test="$sCompId = '9798'" >
            <xsl:value-of select="string('Tape Tandberg')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '13391'" >
            <xsl:value-of select="string('Tape Tandberg')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '8113'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '4244'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '13390'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '14303'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '15371'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '22992'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '23579'" >
            <xsl:value-of select="string('Tape IBM')" />
	  </xsl:when>
          <xsl:when test="$sCompId = '27258'" >
            <xsl:value-of select="string('Tape IBM')" />
          </xsl:when>
					
          <xsl:when test="$sCompId = '12731'" >
            <xsl:value-of select="string('Tape Prostor')" />
	  </xsl:when>					
          <xsl:when test="$sCompId = '12732'" >
            <xsl:value-of select="string('Tape Prostor')" />
	  </xsl:when>
	  <xsl:when test="$sCompId = '30193'" >
            <xsl:value-of select="string('Tape Prostor')" />
          </xsl:when>
					
          <xsl:otherwise>
            <xsl:value-of select="string('Tape Unknown')" />
	  </xsl:otherwise>					
	</xsl:choose>	
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'MD1ooo', 'MD1000'), 'MD1000')" >
	<xsl:value-of select="string('POMP SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'MD112o', 'MD1120'), 'MD1120')" >
	<xsl:value-of select="string('POMP SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'MD1200', 'MD1200'), 'MD1200')" >
	<xsl:value-of select="string('POMP SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'MD1220', 'MD1220'), 'MD1220')" >
	<xsl:value-of select="string('POMP SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'cerc sata', 'CERC SATA'), 'CERC SATA')" >
	<xsl:value-of select="string('SATA PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'lsi', 'LSI'), 'LSI')" >
	<xsl:value-of select="string('LSI PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Name/Display), 'adaptec', 'ADAPTEC'), 'ADAPTEC')" >
	<xsl:value-of select="string('ADAP PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'DRAC 5', 'DRAC 5'), 'DRAC 5')" >
	<xsl:value-of select="string('DRAC5 DRAC5')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'perc 5/E', 'PERC 5/E'), 'PERC 5/E')" >
	<xsl:value-of select="string('PERC5E PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC 5/i Integrated', 'PERC 5/I Integrated'), 'PERC 5/I Integrated')" >
	<xsl:value-of select="string('PERC5iIntegrated PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC 5/i Adapter', 'PERC 5/I Adapter'), 'PERC 5/I Adapter')" >
	<xsl:value-of select="string('PERC5iAdapter PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC 6', 'PERC 6'), 'PERC 6')" >
	<xsl:value-of select="string('PERC6 PERC')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC H')" >
	<xsl:value-of select="string('PERC7 PERC')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/SupportedDevices/Device/Display), '6Gbps SAS')" >
	<xsl:value-of select="string('PERC7 PERC')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/SupportedDevices/Device/Display), '6G Backplane')" >
	<xsl:value-of select="string('PERC7 PERC')" />
      </xsl:when>
      <xsl:when test="contains(string(//SoftwareComponent/SupportedDevices/Device/Display), 'PERC S300')" >
	<xsl:value-of select="string('PERC SOFT')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'CERC 6', 'CERC 6'), 'CERC 6')" >
	<xsl:value-of select="string('CERC6 PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'pv300', 'PV300'), 'PV300')" >
	<xsl:value-of select="string('POMP SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS 5/E Adapter', 'SAS 5/E Adapter'), 'SAS 5/E Adapter')" >
	<xsl:value-of select="string('SAS5E PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS 5/i Integrated', 'SAS 5/I Integrated'), 'SAS 5/I Integrated')" >
	<xsl:value-of select="string('SAS5iIntegrated PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS 5/iR Adapter', 'SAS 5/IR Adapter'), 'SAS 5/IR Adapter')" >
	<xsl:value-of select="string('SAS5iRAdapter PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS 5/iR Integrated', 'SAS 5/IR Integrated'), 'SAS 5/IR Integrated')" >
	<xsl:value-of select="string('SAS5iRIntegrated PERC')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'Internal Tape Adapter', 'Internal Tape Adapter'), 'Internal Tape Adapter')" >
        <xsl:value-of select="string('SAS5iRIntegrated PERC')" />
      </xsl:when> 
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'WD VULCAN,ES', 'WD VULCAN,ES'), 'WD VULCAN,ES')" >
        <xsl:value-of select="string('SAS5iRIntegrated PERC')" />
      </xsl:when>


      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS 6', 'SAS 6'), 'SAS 6')" >
	<xsl:value-of select="string('SAS6 SAS')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'SAS Backplane', 'SAS Backplane'), 'SAS Backplane')" >
	<xsl:value-of select="string('SASBP SASBP')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/Category/Display), 'Serial-Attached SCSI Drives', 'Serial-Attached SCSI Drives'), 'Serial-Attached SCSI Drives')" >
	<xsl:value-of select="string('SASHDD SASHDD')" />
      </xsl:when>
      <xsl:when test="contains(translate(string(//SoftwareComponent/SupportedDevices/Device/Display), 'psu', 'PSU'), 'PSU')" >
	<xsl:value-of select="string('FRMW PSU')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/Category/@value = 'PS'">
	<xsl:value-of select="string('FRMW PSU')" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/@releaseID='R53488'">
	<xsl:apply-templates select="//ComponentType" />
	<xsl:value-of select="'ESM4'" />
      </xsl:when>
      <xsl:when test="//SoftwareComponent/@releaseID='R115969'">
	<xsl:value-of select="string('FRMW BMC')" />
      </xsl:when>
      <xsl:otherwise >
	<xsl:apply-templates select="//ComponentType" />
	<xsl:apply-templates select="//LUCategory" />
      </xsl:otherwise>
    </xsl:choose>	
  </xsl:template>

  <xsl:template match="LUCategory">
    <xsl:value-of select="@value" />
  </xsl:template>

  <xsl:template match="ComponentType">
    <xsl:value-of select="@value" />
    <xsl:call-template name="Space"/>	
  </xsl:template>

  <xsl:template name="Space">
    <xsl:text> </xsl:text>
  </xsl:template>

</xsl:stylesheet>			
