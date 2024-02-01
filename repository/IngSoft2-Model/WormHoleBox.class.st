Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
WormHoleBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: -4.
]
