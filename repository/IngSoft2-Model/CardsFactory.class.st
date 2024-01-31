Class {
	#name : #CardsFactory,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsFactory class >> of: aClass [ 
	
	^ self new initializeOf: aClass
]

{ #category : #initialization }
CardsFactory >> initializeOf: aClass [ 
	self shouldBeImplemented.
]
