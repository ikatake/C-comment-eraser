#cutComment
#c言語のコメントを消す
#state={"first","slash","comment","astah","string"}
#"first"状態では
#	" で状態stringに変化、なお入力文字は出力される
#	/ で状態slashに変化、なお入力文字は廃棄される
#	それ以外では状態を保持、なお入力文字は出力される
#"slash"状態では
#	* で状態commentに変化、なお入力文字は廃棄される
#	/ で状態lineに変化、入力文字は破棄される
#	それ以外で状態firstに戻る。なお/と入力文字が出力される。
#"comment"状態では
#	* で状態astahに変化、なお入力文字は出力されない。
#	それ以外では状態を保持、なお入力文字は廃棄される
#"astah"状態では	
#	/ で状態firstに変化、なお入力文字は廃棄
#	それ以外は状態commentに戻る。入力文字は廃棄
#"string"状態では
#	" で状態firstに変化、入力文字は出力される
#	それ以外では状態を保持、なお入力文字は出力される
#"line"状態では
#	i == NFのときに状態firstに変化、入力文字は破棄
#	それ以外では何もしない
BEGIN{
	state="first";
	FS = "";
}
{
	for(i = 1; i <= NF; i++){
		if(state == "first"){
			if($i == "\"" ){
				state = "string";
				printf("%c", $i"");
			}
			else if($i == "/" ){
				state = "slash";
			}
			else{
				printf("%c", $i"");
			}
		}
		else if(state == "slash"){
			if($i == "*"){
				state = "comment";
			}
			else if($i == "/"){
				state = "line";
			}
			else{
				state = "first";
				printf("/%c", $i"");
			}
		}
		else if(state == "comment"){
			if($i == "*"){
				state = "astah";
			}
		}
		else if(state == "astah"){
			if($i == "/"){
				state = "first";
			}
			else{
				state = "comment";
			}
		}
		else if(state == "string"){
			if($i == "\""){
				state = "first";
				printf("%c", $i"");
			}
			else{
				printf("%c", $i"");
			}
		}
		else if(state == "line"){
			if(i == NF){
				state = "first";
			}
		}
	}
	#改行を挿入
	print ""
}
