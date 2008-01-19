Setting up and compiling the CafeTownsend PureMVC Demo Using the Distribution ZIP

0) You should already have the latest distribution of PureMVC for AS3 on your disk.

1) Unzip the distribution to any folder on your disk. 

   (for instance: c:\development\flex)

2) You will see a Demo_AS3_Flex_CafeTownsend folder. 	
   
   (for instance: c:\development\flex\Demo_AS3_Flex_CafeTownsend)

------------------------------
Steps for Flex Builder/Eclipse
------------------------------

3) Create a new Flex Project called 'Demo_AS3_Flex_CafeTownsend' in Flex Builder/Eclipse, 
   pointing to the new Demo_AS3_Flex_CafeTownsend folder.
   
4) Add the PureMVC Library to the Demo_AS3_Flex_CafeTownsend project's build path. 

   From the FlexBuilder/Eclipse menu do:

	Project -> Properties -> Flex Build Path -> Library Path -> Add SWC 

   And Browse and select the PureMVC.swc from your local PureMVC installation: 
	
	(for instance: C:/development/libs/PureMVC_AS3_2_0/bin/PureMVC.swc

5) Run CafeTownsend.mxml

----------------------------------
Steps for Flex SDK with Apache Ant
----------------------------------
(*Requires Flex Ant Tasks: http://labs.adobe.com/wiki/index.php/Flex_Ant_Tasks)

3) Edit the build.xml located in the Demo_AS3_Flex_CafeTownsend folder.

4) Update the FLEX_HOME property to point to your Flex SDK directory:

	<property name="FLEX_HOME" 	   location="C:\flex_2_sdk\"/> 
	
5) Save the build.xml file.

6) Open the command line.

7) Navigate to the Demo_AS3_Flex_CafeTownsend folder.

8) Run ant ( for instance: C:\development\flex\Demo_AS3_Flex_CafeTownsend > ant )

9) Run CafeTownsend.swf.