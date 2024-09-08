#!/usr/bin/bash



############################################                      script info                 ###############################################

# script purpose : extract information fron any text file

# output 
# 1- file name
# 2- is executable true / false ?
# 3- number of lines inside file 

 


############################################  function declration & glopal varibles & sourcing files   ##############################################

declare FILENAME=" "  # glopal varibe to save file name
declare -g EXE
declare -g NUM_Lines



###########################################    1- Extract file name from path          #######################################
function ExtractFileName(){

#check file is exist or not ? 
declare FILEPATH=$1

if [ ! -f "${FILEPATH}" ]; then
    echo "File \" $FILEPATH \" is not exists"
    exit 1   # end reading of this script file
fi

FILENAME=$(basename "${FILEPATH}") # gets file name only without complete path

#echo " File_Name = "${FILENAME}" "  # print name of this file 
echo  "${FILENAME}"

return 0   #success
}


####################################### 2- is executable true / false ? #########################
function IS_Executable(){

declare FILEPATH=$1     # to access path  
declare -i IS_EXC=0     # initial it is not executable


if [ -x "$FILEPATH" ]; then
    IS_EXC=1         # now it is executable
fi 

   #echo " Executable value = ${IS_EXC} "   # print value 
   echo  ${IS_EXC} 
}


####################################   3- number of lines inside file  #################################

function NumOfLines(){

declare FILEPATH=$1     # to access path  
declare -i LINES_NUMBER=0  #initial value

if [ ! -f "${FILEPATH}" ]; then
    echo "File \" $FILEPATH \" is not exists"
    exit 1   # end reading of this script file
fi

while IFS= read -r line; do
    LINES_NUMBER=$((LINES_NUMBER+1))   # increment counter
done < $FILEPATH

  #echo " NumOfLines = ${LINES_NUMBER} " # print value

  echo ${LINES_NUMBER}
}



function print(){

  if (( $# < 3)); then
      echo " invalid number of arguments "
  fi

  printf " File_Name = %s \n Executable value =%d  \n NumOfLines = %d  \n "  "$1" "$2" "$3"

}


###########################################################        main function           ############################################################### 

function main(){
 FILEPATH=$1
         FILENAME=$(ExtractFileName "$FILEPATH")
         EXE=$(IS_Executable "$FILEPATH"  )
         NUM_Lines=$(NumOfLines  "$FILEPATH")

         print "$FILENAME"  "$EXE"   "$NUM_Lines"

}


###########################################################      calling main            ##################################################################### 

main $1

