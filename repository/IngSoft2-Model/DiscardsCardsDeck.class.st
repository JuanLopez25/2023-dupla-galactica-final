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

{ #category : #cards }
DiscardsCardsDeck >> addCard: aCard [

	(aCard holder isString or: [aCard holder isEmpty])
		ifTrue: [ deck addLast: aCard ]
		ifFalse: [ deck addLast: RedoCard create ]
]

{ #category : #information }
DiscardsCardsDeck >> deckSize [

	^ deck size.
]

{ #category : #initialization }
DiscardsCardsDeck >> intializeCreateDeck [
	
	deck := OrderedCollection new.
]

{ #category : #cards }
DiscardsCardsDeck >> shuffle [

	| aNewDeck |
	aNewDeck := deck.
	deck := OrderedCollection new.
	^ aNewDeck
]
