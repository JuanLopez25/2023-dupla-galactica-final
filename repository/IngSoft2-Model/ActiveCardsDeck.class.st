Class {
	#name : #ActiveCardsDeck,
	#superclass : #Object,
	#instVars : [
		'posetionCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsDeck class >> create [
	^ self new initializeCreate.
]

{ #category : #activation }
ActiveCardsDeck >> activeCard: aCard to: aPlayer [

	posetionCards addLast: (PosetionCard with: aCard of: aPlayer)
]

{ #category : #effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (posetionCards select: [ :posetionCard | 
		   posetionCard holder = aColorPlayer or:
			   posetionCard holder = EveryPlayer new ]) sum: [ :posetionCard | 
		  posetionCard card effect ]
]

{ #category : #desactivation }
ActiveCardsDeck >> desactivate: aPosetionCard [

	aPosetionCard class = PosetionCard
		ifTrue: [ 
			posetionCards
				detect: [ :posetionCard | 
					posetionCard holder = aPosetionCard holder and:
						posetionCard card = aPosetionCard card ]
				ifFound: [ :posetionCard | 
					posetionCards remove: posetionCard.
					^ posetionCard card]
				ifNone: [ 
					Error signal:
						'There are no that type of cards activate in this player or is not valid' ] ]
		ifFalse: [ 
			Error signal:
				'There are no that type of cards activate in this player or is not valid' ]
]

{ #category : #initialization }
ActiveCardsDeck >> initializeCreate [

	posetionCards := OrderedCollection new.
]
