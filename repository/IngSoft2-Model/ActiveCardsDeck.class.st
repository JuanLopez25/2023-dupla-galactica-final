Class {
	#name : #ActiveCardsDeck,
	#superclass : #Object,
	#instVars : [
		'hands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ActiveCardsDeck class >> createDeckFor: aColorCollection [
	^ self new initializeDeckFor: aColorCollection.
]

{ #category : #activation }
ActiveCardsDeck >> activeCard: aCard to: aPlayer [

	hands
		detect: [ :hand | hand owner = aPlayer ]
		ifFound: [ :hand | hand addCard: aCard ]
		ifNone: [ 
			Error signal:
				'There are no that type of cards activate in this player or is not a valid objective' ]
]

{ #category : #effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (hands select: [ :hand | 
		   hand owner = aColorPlayer or: hand owner = EveryPlayer new ]) 
		  sum: [ :hand | hand cards sum: [ :card | card applyEffect ] ]
]

{ #category : #desactivation }
ActiveCardsDeck >> desactivate: aCard to: aPlayer [

	hands
		detect: [ :hand | hand owner = aPlayer ]
		ifFound: [ :hand | ^ hand takeOut: aCard ]
		ifNone: [ 
			Error signal:
				'There are no that type of cards activate in this player or is not a valid objective' ]
]

{ #category : #initialization }
ActiveCardsDeck >> initializeDeckFor: aColorCollection [

	hands := OrderedCollection with: (PlayerHand of: EveryPlayer new).
	aColorCollection do: [ :color | hands addLast: (PlayerHand of: color) ]
]
