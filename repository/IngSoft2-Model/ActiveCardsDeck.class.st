Class {
	#name : #ActiveCardsDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsDeck class >> createDeck [
	^ self new initializeDeck.
]

{ #category : #Activation }
ActiveCardsDeck >> activeCard: aCard [ 
	cards addLast: aCard
]

{ #category : #Effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (cards select: [ :card | card target = aColorPlayer ]) sum: [ :card | 
		  card applyEffect ]
]

{ #category : #Desactivation }
ActiveCardsDeck >> desactivate: anObjectiveCard [

	self isEmpty.
	cards
		detect: [ :card | (card class = anObjectiveCard class) and: [ card target = anObjectiveCard target ] ]
		ifFound: [ :card | cards remove: card ]
		ifNone: [ 
			Error signal:
				'There are no that type of cards activate in this player or is not a valid objective' ]
			
]

{ #category : #Initialization }
ActiveCardsDeck >> initializeDeck [
	cards:= OrderedCollection new.
]

{ #category : #Cards }
ActiveCardsDeck >> isEmpty [

	cards isEmpty ifTrue: [ Error signal: 'There are no permanent cards' ]
]
