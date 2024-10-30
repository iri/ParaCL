mkdir build; cd build

cmake -DCMAKE_BUILD_TYPE=Release -DGRAMMAR="grammar.y" ..

make
#make VERBOSE=1

cp ./pcl ..


