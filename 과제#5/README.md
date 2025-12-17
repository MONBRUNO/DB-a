05-1  
다음 예시와 같은 결과가 나오도록 PL/SQL 프로그램을 작성한다.   
– 인덱스는 영화사 이름이고 Associative Array에 영화사 이름, 영화사 주소, 사장, 사장 주소 등으로 정의된RECORD로 저장  
– Associative Array의 내용을 다음과 같이 출력 (순서는 중요하지 않음)  
– 각 출력 열의 줄이 어느정도는 맞게 출력(lpad, rpad등사용)  
순번 영화사		영화사 주소		     	    사장		사장주소  
[1]  Cold spring 부산시 남구 대연3동 	clark gable       cadiz, ohio  
[2]  columbia     Anchorage, Alaska, USA  malcom mac 	seattle  
  
05-2  
다음 예시와 같이 영화 제작자의 정보를 제작자 이름 순으로 정렬하여 출력한다. 각 제작자에 대해서 운영 영화사 이름의 역순으로 출력한다.   
[1] 제작자 albert t. viola는 영화사를 운영하지 않는다.   
[2] 제작자 alfred molina는 wild character을 운영한다.  
  
05-3  
다음과 같이 순번과 함께 배우에 대한 정보를 화면에 출력하는 PL/SQL 프로그램을 작성한다.  
 배우 이름 순, 각 배우의 출연한 영화의 개봉년도 순으로 출력  
 영화에 출연한 경력이 없는 경우 출력에서 제외  
 Collection 사용하지말것!!!  
[1] alec baldwin : getaway(1994년) 1편 출연  
