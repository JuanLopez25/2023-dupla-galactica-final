Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDeck class >> with: aCard amount: anAmount [

	^ self new initializeWith: aCard amount: anAmount
]

{ #category : #cards }
LoadedDeck >> addCard: aCard amount: anAmount [

	anAmount timesRepeat: [ 
		cardsInDeck addLast: aCard class new ].
]

{ #category : #initialization }
LoadedDeck >> dealCard [

	| selectedCard |
	selectedCard := cardsInDeck at: 1.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
LoadedDeck >> initializeWith: aCard amount: anAmount [

	cardsInDeck := OrderedCollection new.
	aCard isEmpty ifFalse: [ 
	anAmount timesRepeat: [ 
		cardsInDeck addLast: aCard class new ]].
]

{ #category : #information }
LoadedDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
