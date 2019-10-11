set url=http://h5.45yu.com/android/app.html
cd /d %~dp0
rmdir /s/q package
layadcc . -cache -cout package -url %url%