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

{ #category : #activation }
ActiveCardsDeck >> activeCard: aCard [

	cards addLast: aCard
]

{ #category : #effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (cards select: [ :card | card target = aColorPlayer ]) sum: [ :card | 
		  card applyEffect ]
]

{ #category : #desactivation }
ActiveCardsDeck >> desactivate: anObjectiveCard [

	self isEmpty.
	cards
		detect: [ :card | 
			anObjectiveCard isString not and: [ 
				card sameTarget: anObjectiveCard ] ]
		ifFound: [ :card | 
			cards remove: card.
			^ card ]
		ifNone: [ 
			Error signal:
				'There are no that type of cards activate in this player or is not a valid objective' ]
]

{ #category : #initialization }
ActiveCardsDeck >> initializeDeck [

	cards := OrderedCollection new
]

{ #category : #cards }
ActiveCardsDeck >> isEmpty [

	cards isEmpty ifTrue: [ 
		Error signal: 'There are no active permanent cards' ]
]
