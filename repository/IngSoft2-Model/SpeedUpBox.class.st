Class {
	#name : #SpeedUpBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: 4.
]
