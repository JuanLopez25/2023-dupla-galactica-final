Class {
	#name : #DiscardsCards,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DiscardsCards class >> createDeck [
	^ self new intializeCreateDeck.
]

{ #category : #Cards }
DiscardsCards >> addCard: aCard [ 
	
	deck addLast: aCard.
]

{ #category : #Information }
DiscardsCards >> deckSize [

	^ deck size.
]

{ #category : #Initialization }
DiscardsCards >> intializeCreateDeck [
	
	deck := OrderedCollection new.
]
