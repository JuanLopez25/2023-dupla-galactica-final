Class {
	#name : #EveryPlayer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
EveryPlayer >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #information }
EveryPlayer >> isEmpty [

	^ false
]
