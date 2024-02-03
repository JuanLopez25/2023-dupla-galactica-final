Class {
	#name : #ActiveCardsDeck,
	#superclass : #Object,
	#instVars : [
		'posetionCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsDeck class >> createFor: aColorCollection [

	^ self new initializeCreateFor: aColorCollection
]

{ #category : #activation }
ActiveCardsDeck >> activeCard: aCard to: aPlayer [

	posetionCards
		detect: [ :hand | hand holder = aPlayer ]
		ifFound: [ :hand | hand addCard: aCard ]
]

{ #category : #effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (posetionCards select: [ :posetionCard | 
		   posetionCard holder = aColorPlayer or:
			   posetionCard holder = EveryPlayer new ]) sum: [ :posetionCard | 
		  posetionCard cards sum: [ :card | card effect ] ]
]

{ #category : #desactivation }
ActiveCardsDeck >> desactivate: aPosetionCard [

	| aCard |
	posetionCards
		detect: [ :posetionCard | posetionCard = aPosetionCard ]
		ifFound: [ :posetionCard | 
			aCard := posetionCard takeOut: aPosetionCard topCard.
			aCard isEmpty
				ifTrue: [ 
				Error signal: 'The player does not have that type of card active' ]
				ifFalse: [ ^ aCard ] ]
		ifNone: [ Error signal: 'The objective is not valid' ]
]

{ #category : #initialization }
ActiveCardsDeck >> initializeCreateFor: aColorCollection [

	posetionCards := OrderedCollection with:
		                 (PlayerPosetionCards
			                  with: EmptyObject new
			                  of: EveryPlayer new).
	aColorCollection do: [ :color | 
		posetionCards addLast: (PlayerPosetionCards with: EmptyObject new of: color) ]
]
