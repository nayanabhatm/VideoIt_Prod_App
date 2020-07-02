
void main(){

//  String abc="this is running fine.is is is is ";
//  String test="is";
//  List<int> x=List();
//  var i=0;
//
//  while(true)
//  {
//    i=abc.indexOf(test,i);
//    print("i $i");
//    if(i<0)
//      break;
//    x.add(i);
//    i++;
//  }
//
//
//  for(int i in x){
//    print(i);
//  }

  String a="my";
  RegExp re = new RegExp(a);
  String str = "Parse my string my my";
  Iterable<RegExpMatch> matches = re.allMatches(str);
  List<int> x=List();

  matches.forEach((element) {
    x.add(element.start);
    print(str.substring(element.start,element.end));
  });

  str=(str.replaceFirst(a,'you',9));
  print(str);


  print(x);
}