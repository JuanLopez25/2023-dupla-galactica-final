Class {
	#name : #PosetionCard,
	#superclass : #Object,
	#instVars : [
		'card',
		'holder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PosetionCard class >> with: aCard of: aHolder [ 
	
	^self new initializeWith: aCard of: aHolder
]

{ #category : #information }
PosetionCard >> card [

	^ card
]

{ #category : #information }
PosetionCard >> holder [

	^ holder
]

{ #category : #initialization }
PosetionCard >> initializeWith: aCard of: aHolder [ 
	
	card:= aCard.
	holder:= aHolder.
]
