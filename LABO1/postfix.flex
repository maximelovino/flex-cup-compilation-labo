import java.util.Stack;
%% /* options */

%class Postfix
%unicode
%line
%column
%standalone

/* models */

DIGIT=[0-9]
integer={DIGIT}+
operator= \+ | - | \* | \/


%{
  Stack<Integer> numbers = new Stack<>();
  int i = 1;
%}
%{eof

%eof}

%%



{integer} {numbers.push(Integer.valueOf(yytext()));}

{operator} { Integer x1 = numbers.pop();
		Integer x2 = numbers.pop();
		switch(yytext()){
			case "+": numbers.push(x1+x2); break;
			case "-": numbers.push(x2-x1); break;
			case "/": numbers.push(x2/x1); break;
			case "*": numbers.push(x1*x2); break;
			default: break;
		}
}

\n {
	if (numbers.size()!=1){
		System.out.println("There is an error on line "+i);
		numbers.clear();
	}else{
		Integer finalResult = numbers.pop();
		System.out.println("final result of line "+i+": "+finalResult);
	}
	i++;
}

. {;}
