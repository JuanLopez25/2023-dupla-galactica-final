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

	aPlayer isString
		ifTrue: [ 
			(hands detect: [ :hand | 
				 hand owner = aPlayer and: [ hand owner class ~= EveryPlayer ] ]) 
				addCard: aCard ]
		ifFalse: [ 
		(hands detect: [ :hand | hand owner = aPlayer ]) addCard: aCard ]
]

{ #category : #effects }
ActiveCardsDeck >> calculateEffectOn: aColorPlayer [

	^ (hands select: [ :hand | hand owner = aColorPlayer ]) sum: [ :hand | 
		  hand applyEffect ]
]

{ #category : #desactivation }
ActiveCardsDeck >> desactivate: aCard to: aPlayer [

	aPlayer isString
		ifTrue: [ 
			hands
				detect: [ :hand | hand owner = aPlayer and: [ hand owner class ~= EveryPlayer] ]
				ifFound: [ :hand | ^ hand takeOut: aCard ]
				ifNone: [ 
					Error signal:
						'There are no that type of cards activate in this player or is not a valid objective' ] ]
		ifFalse: [ hands
				detect: [ :hand | hand owner = aPlayer ]
				ifFound: [ :hand | ^ hand takeOut: aCard ]
				ifNone: [ 
					Error signal:
						'There are no that type of cards activate in this player or is not a valid objective' ] ] 
]

{ #category : #initialization }
ActiveCardsDeck >> initializeDeckFor: aColorCollection [

	hands := OrderedCollection with: (PlayerHand of: EveryPlayer new).
	aColorCollection do: [ :color | hands addLast: (PlayerHand of: color) ]
]
