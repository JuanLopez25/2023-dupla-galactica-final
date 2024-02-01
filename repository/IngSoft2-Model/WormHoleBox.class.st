Class {
	#name : #WormHoleBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
WormHoleBox >> duplicate [

	^ self class new
]

{ #category : #effect }
WormHoleBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: -4.
]
