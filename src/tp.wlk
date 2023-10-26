import wollok.game.*
object cursor { //hay que restarle 4 a la x, y  de la posicion de la carta, la y se mantiene para todos las posiciones del cursor
	var y = 11
	var x = 34
	var indice = 0
	method moverDerecha(){
		if (x+235.75 > 977.15) {
			x=34
			indice=0
		} else 
			{ 
			x= x+235.75 
			indice++	
			}
		}	
	method moverIzquierda(){
		if (x-235.75 < 34){
			x=977.15
			indice=4
		} else 
			{ 
			x= x-235.75
			indice--
			}
	}
	
	method image() = "Cursor.png"
	method position()= game.at(x,y)
	method obtenerIndice(){
		return indice
	}
}
object tpIntegrador {
	method jugar() {
		
		var menuInicio = new Menu()
		game.cellSize(1)
		game.width(1200)
		game.height(740)
		game.boardGround("fondoCancha.png")
		game.start()
		game.addVisual(menuInicio.devolverMessi())
		game.addVisual(menuInicio.devolverEnemigoActual())
		menuInicio.empezarTurno(cursor)
		}
}
class Personaje{
	var vida
	var danio 
	var defensa
	var x
	var y
	var ruta
	var listaCartas 
	var mano = new List()
	var mazo = new List()
	var stamina = 0
	
	method asignarMazo(){
		mazo = listaCartas.drop(5)
	}
	method mazo(){
		return mazo
	}
	method asignarMano(){
		mano = listaCartas.take(5)
	}
	method mano(){
		return mano
	}
	method position() = game.at(x,y)
	
	method image(){
		return ruta
	}
	
	method vidaPersonaje(){
		return 0.max(vida)
	}

	method devolverDefensa(){
		return defensa
	}
	method consultarDanio(){
		return danio
	}
	method constultarStamina(){
		return stamina
	}
	method atacar(objetivo){
		objetivo.recibeDanio(danio)
	}
	method recibeDanio(dmg){
		vida = vida - (dmg * (1 - defensa))
	}
	method aumentarDefensa(aumento){  //el aumento es un nro entre 0 y 1
		defensa = defensa + aumento 
	}
	method agregarCarta(){
		mano.add(mazo.head())
		mano = mano.filter{i => i != []}	
	}


	method sePuedeJugar(carta){
		return	carta.consultarCosto() <= stamina
	}
	
	
	method juega (enemigo, indice){
		var c = mano.get(indice)
		if (self.sePuedeJugar(c)){
			c.hacerEfecto(self,enemigo)
			mano.remove(c)
		} else { game.say(c,"No me podes jugar te falta mana")
		}
		//	mano.add(mazo.head())
		//	mano = mano.filter{i => i != []}
	}
}


// keyboard.i().onPressDo { game.say(pepita, "hola!") }
// keyboard.rigth().onPressDo {cambiar posicion cursor }
// keyboard.backspace().onPressDo { jugar la carta con posicion cursor}
//object barraVida {
//	const ruta
//	const x
//	const y	
//}


class Carta{ //Las cartas no deberian tener posicion, la posicion la voy dando segun la disponibilidad de la mano, y ya son definidas estas posiciones
	var costo
	var x
	const y =15
	var ruta
	method consultarCosto() = costo
	
	method image() = ruta
	method position() = game.at(x,y)
}
class CartaAtaque inherits Carta{
	method hacerEfecto(atacante, atacado){
		atacante.atacar(atacado)
	}
}
class CartaAumento inherits Carta{
	var aumento
	method hacerEfecto(personaje, atacado){
		personaje.aumentarDefensa(aumento)
	}	
}

class Menu{
	
	const balonesDeOro = new CartaAtaque(costo = 1 , ruta = "BalonesDeOro.png", x= 441)
	const hormonas = new CartaAumento(costo = 1, ruta = "Hormonas.png", x= 221, aumento= 10)
	const dibu = new CartaAumento(costo = 1, ruta = "Dibu2.png", x= 38, aumento= 0.2)
	const hormonas2 = new CartaAumento(costo = 1, ruta = "Hormonas.png", x= 221, aumento= 10)
	const dibu2 = new CartaAumento(costo = 1, ruta = "Dibu2.png", x= 38, aumento= 0.2)
	
	const listaMessi = [balonesDeOro, hormonas, dibu,hormonas2,dibu2]
	const listaEnemigo = [hormonas,hormonas, balonesDeOro]
	
	const messi = new Personaje(vida=500, danio = 20, defensa=0.4, ruta = "Messi.png",x=360, y=423, listaCartas= listaMessi,stamina=5)
	const enemigo1 = new Personaje(vida = 30, danio = 40, defensa = 0.2, ruta="Mbappe.png",x=740,y=420, listaCartas = listaEnemigo,stamina=5)
	

//Posiciones Cartas: 38 , 273.75 , 509.5 , 745.25, 981 

	
	
	method elegirCarta(cursor){     //tiene que ir moviendo el cursor hasta que toque espacio
		var r=0
		game.addVisual(cursor)
		keyboard.right().onPressDo{cursor.moverDerecha()}
		keyboard.left().onPressDo{cursor.moverIzquierda()}
		//game.whenKeyPressedDo(keyboard.left(), cursor.moverIzquierda())
		//keyboard.left().onPressDo ({cursor.moverIzquierda()})
		//whenKeyPressedDo(key, action)   native
 		//Adds a block that will be executed each time a specific key is pressed
		
		//whenKeyPressedDo(keyboard.backspace(), return cursor.obtenerIndice())
		keyboard.enter().onPressDo{r= cursor.obtenerIndice()}
		
		return r
	}
	
	
	method empezarTurno (cursor){
	//game.whenKeyPressedDo(keyboard.right(),{cursor.moverDerecha()})
	// game.whenKeyPressedDo(keyboard.left(), cursor.moverIzquierda())
	//keyboard.left().onPressDo ({cursor.moverIzquierda()})
		
	messi.asignarMano()
	messi.asignarMazo()

	self.mostrarEnPantalla(messi.mano())
	//game.addVisual(balonesDeOro)
	//game.addVisual(hormonas)
	
	messi.juega(enemigo1, self.elegirCarta(cursor))	
	//enemigo1.juega(messi,listaEnemigo)
	
	if	(self.estaMuerto(messi)) {
	// animacion de que muere messi y se muestra un "gano Francia"
	// se cierra el juego luego de 10 seg
	}
	else {
		if (self.estaMuerto(enemigo1)){ 
		// animacion de que muere enemigo y se muestra un "gano Argentina"
		} 
		else {
			 if (messi.mano().lenght()<6)
			 	{
			 	messi.agregarCarta()				 
				}
			}
			} 
		self.empezarTurno(cursor)
	}
	
	method mostrarEnPantalla(mano){	// SE QUE ES FEO PERO LO HICE ASI DE MOMENTO PARA TANTEAR
		
		game.addVisualIn(mano.get(0),game.at(38,15))
		game.addVisualIn(mano.get(1),game.at(273.75,15))
		game.addVisualIn(mano.get(2),game.at(509.5,15))
		game.addVisualIn(mano.get(3),game.at(745.25,15))
		game.addVisualIn(mano.get(4),game.at(981,15))
		
		
		//mano.forEach { carta => game.addVisualIn(carta, )}
	}
	// el tablero va de 38 a 1162, se dejan 64,75 pixeles entre cada carta
	//quiero que entre cada carta se dejen 64,75 pixeles
	//la primera posicion para mostrar carta es 38, 17, siendo la 1ra la que varia
	//De todas formas hay siempre como maximo 5 cartas, asi que tal vez podria tener las posiciones definidas
	//Serian: 30 , 213 , 376 , 559, 742 
	//method mostrarListaCartas(listaCartas){
//		var posInicial = game.at(38,17)
	//	listaCartas.forEach({c => self.mostrarCartaPantallaPosicion(c,posInicial)})
	//}
	
	//method mostrarCartaPantallaPosicion(carta, posicion){
	//	game.addVisualIn(carta, posicion)
	//}
	
	method consultarVida(personaje){
	return personaje.vidaPersonaje()
	}
	
	method consultarDefensa(personaje){
	return personaje.devolverDefensa()
	}
		
	method estaMuerto(personaje){
		return (self.consultarVida(personaje) == 0)
	}
	method devolverEnemigoActual(){
		return enemigo1
	}
	method devolverMessi(){
	return messi
	}

}



