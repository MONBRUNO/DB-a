06-1  
대소문자 구분없이 uk, _, california, ZZZ, new york, texas, chicago 등이 주소에 포함되어 있는 MovieExec의 영화임원 정보를 다음 페이지와 같이 출력하는 PL/SQL 프로그램 1.sql을 작성한다.  
 Dynamic SQL 방식을 사용하여야 한다.
 stored procedure나 stored function 등을 사용하는 경우 declare 문장 위에 stored function/procedur의 코드를 추가하고 end; 문장 다음 줄에 반드시 /를 추가해야 한다.
 재산 액수는 출력 예시와 같은 통화 표현법을 적용한다.
 해당 주소의 영화임원이 없는 경우 해당없음으로 출력한다.
 아래 예시는 참고용이며 실제 출력 결과와 다를 수 있다.
[1] uk 가 주소에 있는 임원들 : 평균재산 액수-640,000.00원  
	(1) alfred molina(london, england, uk에 거주) : 재산 : 640,000.00원  
