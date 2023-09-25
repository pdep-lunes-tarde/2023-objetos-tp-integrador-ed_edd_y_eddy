# Grupo

Nombre: Ed, Edd y Eddy

Integrantes: Terrizzi Juan Martin, Lombardo Fabrizio, Belfiore Nicolas

# Consigna TP Integrador

Hacer un juego aplicando los conceptos de la materia. El tp tiene una parte práctica, que es programar el juego en sí, y una parte teórica, que es justificar decisiones que hayan tomado y mencionar para resolver qué problemas utilizaron los conceptos de la materia.
El TP debe:
- aplicar los conceptos que vemos durante la materia.
- tener tests para las funcionalidades que definan.
- evitar la repetición de lógica.

# Como correrlo

Boton derecho sobre `juego.wpgm > Run as > Wollok Program`.

# Entregas

Van a haber varios checkpoints presenciales en los cuales vamos a ver el estado del tp, dar correcciones y junto con ustedes decidir en qué continuar trabajando.
Los checkpoints presenciales están en la página: https://www.pdep.com.ar/cursos/lunes-tarde

# Parte teórica

Les vamos a ir dando preguntas para cada checkpoint que **tienen que** dejar contestadas por escrito. Pueden directamente editar este README.md con sus respuestas:

--------------------

## Checkpoint 1: 25/9

a) Detectar un conjunto de objetos que sean polimórficos entre sí, aclarando cuál es la interfaz según la cuál son polimórficos, y quién los trata de manera polimórfica.

CartaAtaque y CartaDefensa entienden hacerEfecto(), que es un metodo que va a llamar Personaje.

b) Tomar alguna clase definida en su programa y justificar por qué es una clase y no se definió con object. Optamos por definir Personaje como una clase dado que el protagonista y los enemigos van a tener los mismos atributos y deberian entender los mismos metodos, tales como atacar y aumentarDefensa.

c) De haber algún objeto definido con object, justificar por qué.

