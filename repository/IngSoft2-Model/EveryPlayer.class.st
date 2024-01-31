Class {
	#name : #EveryPlayer,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #information }
EveryPlayer >> = aPlayer [

	^ aPlayer class = self class
]

{ #category : #information }
EveryPlayer >> isEmpty [

	^ false
]
