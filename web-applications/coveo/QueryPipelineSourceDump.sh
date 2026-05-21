#!/bin/bash

# https://github.com/coveo/cli

#coveo auth:login --organization '<Organization Name>'

# Set variables for command arguments
PIPELINE='<Query Pipeline Name>'
SOURCE='<Source Name>'
NAME='<File Name>'
DESTINATION='/Users/$whoami/Dumps/06012023/'
#ADDITIONAL_FILTER='@language=="en_us"'
#FIELDS_TO_EXCLUDE='allfieldvalues sfcreatedbyname sfcreatedbyname sysclickableuri sysfiletype language td_sf_target_url sffirstpublisheddate foldingparent sysrowid td_source_name uri syscollection sfadditionalinformationc sfdcfeature sfobjectivec sfprocedurec metadatasampling sfinternalnotesc sfsolution__c sfissuec sfcausec sfresolutionc sfversionc sfsourceid sfactualcreatorrname'

# Run the Coveo CLI command
#coveo org:search:dump --pipeline "$PIPELINE" --source "$SOURCE" --name "$NAME" --destination "$DESTINATION" --additionalFilter $ADDITIONAL_FILTER  --fieldsToExclude $FIELDS_TO_EXCLUDE

coveo org:search:dump --pipeline "$PIPELINE" --source "$SOURCE" --name "$NAME" --destination "$DESTINATION"