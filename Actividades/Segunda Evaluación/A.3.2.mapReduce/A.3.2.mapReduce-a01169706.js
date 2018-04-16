//Daniela Rebeca Anguiano Ojeda a01169706

//contesta las siguientes preguntas:
//1.        Cuántos restaurantes hay por ZipCode
var funcMapa1 = function() {
  	emit(this.address.zc, 1);
};

var funcReduce1 = function(zc, values) {
	return values.length;
  
};

db.restaurants.mapReduce(
  	funcMapa1,
  	funcReduce1,
  	{
    	out:"numRestaurantsPerZipCode"
  	})

//2.        Cuál es el total de scores por usuario
var funcMapa2 = function() {
  	this.grades.forEach((value)=>{
    	emit(this.name, value.score);
  	});
};
var funcReduce2 = function(name, scores) {
  	const sum = (acumulador, valor) => acumulador + valor;
  	var t = scores.reduce(sum);
  	return t;
};

db.restaurants.mapReduce(
  	funcMapa2,
 	funcReduce2,
  	{
    	out:"ScoresPorUsuario"
  	})

//3.        Cuántos restaurantes obtuvieron el grade A, Grade B y Grade C
var funcMapa3 = function(){
  	this.grades.forEach((value)=>{
    	emit(value.grade, 1);
  	});
};
var funcReduce3 = function(grade, grades){
	const sum = (acumulador, valor) => acumulador + valor;
  	var t = grades.reduce(sum);
  	return t;
};

db.restaurants.mapReduce(
  	funcMapa3,
  	funcReduce3,
  	{
    	out:"obtenerGradeABC"
  	})

//4.        Agrupa los restaurantes por “cuisine” y cuenta cuántos restaurantes hay por cada categoría
db.restaurants.mapReduce(
    function(){
        emit(this.cuisine, 1)
    },
    function(name, count){
        return Array.sum(count);
    },
    {out:"restaurantesPorCategoria"}
);

//5.        Cuáles son los 10 restaurantes más cercanos a:
//                Restaurant_id: 40360045

var funcMapa4 = function() {
  	emit(this.name, );
};
var funcReduce4 = function() {
  	return
};

db.restaurants.mapReduce(funcMapa4,funcReduce4,{out:"restaurantesMasCercanos"})

//6.¿Cuántos grades hay por usuario?

var funcMapa5 = function() {
  emit(this.name, this.grades.length);
};
var funcReduce5 = function(names, length) {
  return length[0];
};
db.restaurants.mapReduce(
  funcMapa5,
  funcReduce5,
  {
    out:"gradesPorUsuario"
  })


