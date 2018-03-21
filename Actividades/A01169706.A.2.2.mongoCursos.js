//Daniela Rebeca Anguiano Ojeda a01160706

Use universidadBA

db.createCollection("cursos");

db.cursos.insert({curso:{titulo:"curso1",profesorTitular:"Ariel",año:2018}});
db.cursos.insert({curso:alumnos:{}});
db.cursos.insert({curso:profesores:{}});


db.cursos.update({ "titulo" : ObjectId("curso1")},{$set:{"curso.evaluaciones":{teoricas:10,practicas:15}}});

db.cursos.update({ "titulo" : ObjectId("curso1")},{$set:{"curso.evaluacion":[70,83,65,92]}});

db.cursos.update({ "titulo" : ObjectId("curso1")},{$set:{"curso.evaluacionProfesor":[70,83,65,92]}});

db.cursos.update({ "titulo" : ObjectId("curso1")},{$set:{"curso.comentarios":["bueno","intenso","cargado","excelente"]}});

db.cursos.update({"titulo" : ObjectId("curso1")},{$set:{"alumnos":[{nombre:"Daniela Rebeca Anguiano Ojeda",matricula:"a01169706",direccion:"cedros14"},{nombre:"Javier Esponda Hernandez",matricula:"a01374645",direccion:"roma276"},{nombre:"Josep Romagosa",matricula:"a01374637",direccion:"miguel miramon"},{nombre:"Samanntha Anguiano",matricula:"a01169707",direccion:"Cedros14"}]}});

db.cursos.update({"titulo" : ObjectId("curso1")},{$set:{"alumnos.$[].cursos":[ {nombre:"curso1",anoDeInscripcion:2018,calificaciones:[80,81,81,82],califFinal:81},{nombre:"curso2",anoDeInscripcion:2017,calificaciones:[78,79,79,80],califFinal:79},{nombre:"curso3",anoDeInscripcion:2016,calificaciones:[90,91,91,92],califFinal:91}]}});

db.cursos.update({"titulo" : ObjectId("curso1")},{$set:{"profesores":{nombre:"Ariel",nomina:"0987654",dirección:"TecSantaFe"}}});

db.cursos.update({"titulo" : ObjectId("curso1")},{$set:{"profesores.$[].cursos":[{nombre:"curso1",anoImpartio:2018}]}});

