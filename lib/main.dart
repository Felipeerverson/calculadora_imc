import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  String _InfoText = "Informe seus dados!";

  void _resetFields (){
    weightController.text ="";
    heightController.text ="";
    setState(() {
      _InfoText = "Informe seus dados!";
    });
  }

  void calculate (){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height*height);
      print(imc);
      if(imc < 18.6) {
        _InfoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
       } else if(imc >= 18.6 && imc < 24.9){
         _InfoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
       } else if (imc >= 24.9 && imc < 29.9){
         _InfoText = "levemente acima do peso (${imc.toStringAsPrecision(3)})";
       } else if (imc >= 29.9 && imc < 34.9){
         _InfoText = "Obesidade grau I  (${imc.toStringAsPrecision(3)})";
      }  else if (imc >= 34.9 && imc < 39.9){
         _InfoText = "Obesidade grau II  (${imc.toStringAsPrecision(3)})";
      }  else if (imc >= 40.0 ){
        _InfoText = "Obesidade grau III  (${imc.toStringAsPrecision(3)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh) ,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0 , 10.0, 0.0),
        child: Form(
          key: FormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.orangeAccent,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso kg",
                    labelStyle: TextStyle(color: Colors.orangeAccent),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura cm",
                    labelStyle: TextStyle(color: Colors.orangeAccent),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return"Insira sua Altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: (){
                        if (FormKey.currentState.validate()){
                          calculate();
                        }
                      },
                      child: Text("Calcular",
                        style: TextStyle(color: Colors.orange, fontSize: 25),),
                    ),
                  ),
                ),
                Text( _InfoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange,fontSize: 25),),
              ],
            ),
        ),
      ),
    );
  }
}
