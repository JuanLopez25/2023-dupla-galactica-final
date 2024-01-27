Class {
	#name : #DiscardsCardsDeck,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DiscardsCardsDeck class >> createDeck [
	^ self new intializeCreateDeck.
]

{ #category : #Cards }
DiscardsCardsDeck >> addCard: aCard [ 
	
	deck addLast: aCard.
]

{ #category : #Information }
DiscardsCardsDeck >> deckSize [

	^ deck size.
]

{ #category : #Initialization }
DiscardsCardsDeck >> intializeCreateDeck [
	
	deck := OrderedCollection new.
]

{ #category : #Card }
DiscardsCardsDeck >> shuffle [

	|aNewDeck|
	deck isEmpty ifTrue: [ ^ OrderedCollection new ].
	deck do: [ :card | card newHolder: EmptyObject new].
	aNewDeck:= deck.
	deck := OrderedCollection new.
	^aNewDeck.
]
