Class {
	#name : #AtomicBombBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
AtomicBombBox >> duplicate [

	^ self class new
]

{ #category : #effect }
AtomicBombBox >> effect: aPlayer in: aGame [

	aGame moveAllToTheStart
]
