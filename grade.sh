CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
    then
        echo "File was found"
    else
        echo "Needs ListExample.java. Check that file is named correctly."
        exit 2
fi

cp ListExamples.java ..
cd ..

javac -cp CPATH *.java

if [[ $? -eq 0 ]]
    then
        echo "Compiling passed with no issues."
    else   
        echo $?
        exit 1
fi

java -cp CPATH org.junit.runner.JUnitCore TestListExamples > out.txt

if [[ `grep "FAILURES" out.txt` != "" ]]
    then 
        echo "You failed."
    else
        echo "Yay, you passed."
fi