//Evaluación2
//Daniela Rebeca Anguiano Ojeda a01169706
//“map-reduce”

//Utiliza la base de datos GRADES.JSON para contestar las siguientes preguntas:
//¿Cuál es el total de alumnos inscritos?

db.grades.mapReduce(
    function(){
        emit(this.student_id, 1)
    },
    function(name, count){
        return Array.sum(count);
    },
    {out:"inscritos"})
//Respuesta:50

//¿Cuántos cursos se han impartido?

db.grades.mapReduce(
    function(){
        emit(this.class_id, 1)
    },
    function(name, count){
        return Array.sum(count);
    },
    {out:"cursosImpartidos"})
//Respuesta:31

//Encuentra, para cada alumno, su promedio obtenido en cada una de las clases en las que fue inscrito (promedia exámenes, quizes, tareas y todas las actividades realizadas que contenga un grade)
db.grades.mapReduce(
    function(){
        this.scores.forEach((value)=>{emit(this.student_id, value.score)}
    )},
    function(name, score){
        return Array.sum(score)/score.length;
    },
    {out:"promedios"}).find()


	

//¿Cuál fue la materia que tiene la calificación más baja (muestra el id de la materia, el id del alumno y la calificación)?
db.grades.aggregate([
  {
    $project: {
      student: "$student_id",
      class: "$class_id",
      average: {
        $avg: "$scores.score"
      }
    }
  },
  {
    $group: {
      _id: {},
      min: {
        $min: "$average"
      }
    }
  }
]);
//¿Cuál es la materia en la que se han dejado más tareas?

//¿Qué alumno se inscribió en más cursos?
//4 alumnos inscribieron 11 cursos

db.partial.mapReduce(
    function(){
        emit(this.student_id, 1);
    },
    function(student_id, values){
        return Array.sum(values);
    },
    {out:"alumnoEnMasCursos"}).find().sort({value:-1}).limit(1).pretty()


//¿Cuál fue el curso que tuvo más reprobados?
db.grades.mapReduce(
    function(){
        this.scores.forEach((value)=>{emit(this.student_id, value.score)}
    )},
    function(name, score){
        return Array.sum(score)/(student.num_scores);
    },
    {out:"CursoReprobados"}).find()



//Notas: 
//códigos similares equivalen a 0
//el profesor no resuelve dudas (todo está en google)
