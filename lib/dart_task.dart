void main(){
  print("Hello World");
  ref();
}

List l = [9, 7, 6, 5, 9, 3, 4, 4, 2];

List m = [];
bool isDuplicate = false;

ref(){
  print("---Dart Task----");

  for(int i = 0; i < l.length; i++){
    //print(l[i]);
    // find duplicate
    for(int j = i + 1; j < l.length; j++){
      // if(l[i] == l[j]){
      //    print("Duplicate: ${l[i]}");
      //    print("Index: ${i} and ${j}");
      // }
      if(l[i] == l[j]){
        isDuplicate = true;
        print("Duplicate: ${l[i]}");
        break;

      }
    }
    if(!isDuplicate){
      m.add(l[i]);
    }
    isDuplicate = false;

  }
  print(m);
// ascending order
  for(int i = 0; i < m.length; i++){

    for(int j = i + 1; j < m.length; j++){
      if(m[i] > m[j]){
        int temp = m[i];
        m[i] = m[j];
        m[j] = temp;

      }
    }
  }
  print(m);

}
