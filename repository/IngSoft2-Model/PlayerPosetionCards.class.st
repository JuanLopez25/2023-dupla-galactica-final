Class {
	#name : #PlayerPosetionCards,
	#superclass : #Object,
	#instVars : [
		'holder',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerPosetionCards class >> with: aCard of: aHolder [ 
	
	^self new initializeWith: aCard of: aHolder
]

{ #category : #comparing }
PlayerPosetionCards >> = aPosetionCard [

	(aPosetionCard isKindOf: self class)
		ifTrue: [ ^ aPosetionCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #'cards managment' }
PlayerPosetionCards >> addCard: aCard [

	aCard isEmpty ifFalse: [ cards addLast: aCard ]
]

{ #category : #information }
PlayerPosetionCards >> cards [

	^ cards
]

{ #category : #information }
PlayerPosetionCards >> has: aCard [

	cards detect: [ :card | card = aCard ] ifFound: [ :card | ^ true ].
	^ false
]

{ #category : #information }
PlayerPosetionCards >> holder [

	^ holder
]

{ #category : #initialization }
PlayerPosetionCards >> initializeWith: aCard of: aHolder [ 
	
	cards:= OrderedCollection new.
	aCard isEmpty ifFalse: [ cards addLast: aCard ].
	holder:= aHolder.
]

{ #category : #'cards managment' }
PlayerPosetionCards >> takeOut: aCard [

	cards
		detect: [ :card | 
			card = aCard or: (card hasEffect not and: [ card redoing = aCard ]) ]
		ifFound: [ :card | 
			cards remove: card.
			^ card ]
		ifNone: [ ^ EmptyObject new ]
]

{ #category : #information }
PlayerPosetionCards >> topCard [

	^ cards at: 1
]
