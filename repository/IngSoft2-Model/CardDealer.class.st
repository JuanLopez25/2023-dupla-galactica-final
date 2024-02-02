Class {
	#name : #CardDealer,
	#superclass : #Object,
	#instVars : [
		'deck',
		'discardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardDealer class >> with: aDeck [ 

	^ self new intializeWith: aDeck.
]

{ #category : #information }
CardDealer >> cardsToDeal [

	^ deck cardsToDeal
]

{ #category : #cards }
CardDealer >> dealCard [

	deck isEmpty ifTrue: [ 
		discardDeck shuffle do: [ :card | 
			deck addCard: card amount: 1 ].
		deck isEmpty ifTrue: [ ^ EmptyObject new ] ].
	^ deck dealCard
]

{ #category : #cards }
CardDealer >> discard: aCard [

	discardDeck addCard: aCard amount: 1.
]

{ #category : #information }
CardDealer >> discardCardsDeskAmount [

	^ discardDeck cardsToDeal
]

{ #category : #initialization }
CardDealer >> intializeWith: aDeck [

	deck := CardsDeck create.
	discardDeck := aDeck.
]
