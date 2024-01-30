Class {
	#name : #AveilableCardsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AveilableCardsDeck class >> with: aCard amount: anAmount [

	^ self new initializeWith: aCard amount: anAmount
]

{ #category : #cards }
AveilableCardsDeck >> addCard: aCard amount: anAmount [

	anAmount timesRepeat: [ 
		cardsInDeck addLast: aCard class create ].
]

{ #category : #information }
AveilableCardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #cards }
AveilableCardsDeck >> dealCard [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
AveilableCardsDeck >> initializeWith: aCard amount: anAmount [

	cardsInDeck := OrderedCollection new.
	aCard isEmpty ifFalse: [ 
	anAmount timesRepeat: [ 
		cardsInDeck addLast: aCard class create ]].
]

{ #category : #information }
AveilableCardsDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
