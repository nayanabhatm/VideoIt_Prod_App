import 'package:flutter/cupertino.dart';
import 'Question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuestionBank{
  int _questionNum=0;
  List<Question> _questionBank=[
  Question('Python is an interpreted language', true),
  Question('To execute Python statements, the statements must be entered into a file', false),
  Question('Python\'s print statement writes items to the screen', true),
  Question('A full list of Python keywords can be obtained from Python itself, using the Python keyword module',true),
  Question('A variable called name refers to the same value as a variable called NAME',true)
  ];

  String getQuestion(){
   return(_questionBank[_questionNum].question);
  }

  bool getAnswer(){
    return(_questionBank[_questionNum].answer);
  }

  void nextQuestion(){
    if(_questionNum <_questionBank.length-1){
      _questionNum++;
    }
  }

  bool isFinished(){
    if(_questionNum >= _questionBank.length-1){
      resetQuestionNum();
      return true;
    }
    else{
      return false;
    }
  }

  void resetQuestionNum(){
    _questionNum=0;
  }

}