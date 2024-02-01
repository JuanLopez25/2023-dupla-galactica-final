Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombBox >> effect: aPlayer in: aGame [

	aGame moveAllToTheStart
]
